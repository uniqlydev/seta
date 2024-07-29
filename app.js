const express = require('express');
const app = express();
const port = 3000;
const admin = require('firebase-admin');
const path = require('path');

const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());


app.get('/', (req, res) => {
    res.render('main.ejs');
});

app.get('/login', (req, res) => {
    res.render('login.ejs');
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    if (username === 'admin' && password === 'admin') {
        // Redirect if successful login
        res.redirect('/home');
    } else {
        res.send('Login Failed');
    }
});

app.get('/home', async (req, res) => {
    try {   
        const patientsCollection = db.collection('patients');
        const snapshot = await patientsCollection.get();
        const patients = snapshot.docs.map(doc => doc.data());

        res.render('home.ejs', { patients });
    } catch (error) {
        res.send('Error');
    }
});

app.get('/patients', (req, res) => {
    res.render('patients.ejs');
});

app.get('/prescriptions', async (req, res) => {
    try {
        const urlParams = new URLSearchParams(req.query);
        const uid = urlParams.get('uid');

        const patientsCollection = db.collection('patients');
        const prescriptionsCollections = db.collection('prescriptions');

        const patient = await patientsCollection.doc(uid).get();
        const patientData = patient.data();
        const username = patientData.username;

        const snapshot = await prescriptionsCollections.where('patientId', '==', username).get();
        const prescriptions = snapshot.docs.map(doc => doc.data());

        res.render('prescriptions.ejs', { prescriptions, patient: patientData });
    } catch (error) {
        res.send('Error');
    }
});

app.post('/update-status', async (req, res) => {
    try {
        const { prescriptionId, claimed } = req.body;
        const prescriptionCollection = db.collection('prescriptions');

        await prescriptionCollection.doc(prescriptionId).update({ claimed });

        res.json({ message: "Status has been updated." });
    } catch (error) {
        res.status(500).json({ message: "Error updating status." });
    }
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});