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


// Landing Page
app.get('/', (req, res) => {
    res.render('main.ejs');
});

// Login Page
app.get('/login', (req, res) => {
    res.render('login.ejs');
});

// Login Functionality
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    if (username === 'admin' && password === 'admin') {
        // Redirect if successful login
        res.redirect('/home');
    } else {
        res.send('Login Failed');
    }
});

// Patients Page (Home cuz its kind of like the main page talaga I think)
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

// List of Prescriptions per Patient
app.get('/prescriptions', async (req, res) => {
    try {
        const urlParams = new URLSearchParams(req.query);
        const uid = urlParams.get('uid');

        // Ensure 'uid' is provided
        if (!uid) {
            return res.status(400).send('Patient ID (uid) is required.');
        }

        // Reference to the specific patient's document
        const patientDocRef = db.collection('patients').doc(uid);

        // Get the patient data
        const patientSnapshot = await patientDocRef.get();
        if (!patientSnapshot.exists) {
            return res.status(404).send('Patient not found.');
        }
        const patientData = patientSnapshot.data();

        // Reference to the prescriptions subcollection of the patient
        const prescriptionsCollection = patientDocRef.collection('prescriptions');

        // Get the prescriptions data
        const prescriptionsSnapshot = await prescriptionsCollection.get();
        const prescriptions = prescriptionsSnapshot.docs.map(doc => ({
            id: doc.id,
            ...doc.data()
        }));

        // Render the prescriptions view with both patient and prescriptions data
        res.render('prescriptions.ejs', { prescriptions, patient: patientData });
    } catch (error) {
        console.error('Error retrieving data:', error);
        res.status(500).send('Error retrieving data.');
    }
});


// Update Prescription Status Functionality
app.post('/update-status', async (req, res) => {
    try {
        const { patientUid, prescriptionId, claimed, claimDate } = req.body;
        
        const patientDocRef = db.collection('patients').doc(patientUid);

        // Reference to the specific prescription document
        const prescriptionDocRef = patientDocRef.collection('prescriptions').doc(prescriptionId);

        // Update the prescription status
        await prescriptionDocRef.update({
            claimed,
            claimDate
        });

        res.json({ message: 'Status updated successfully.' });
    } catch (error) {
        res.status(500).json({ message: "Error updating status." });
    }
});

// Port Listener
app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});