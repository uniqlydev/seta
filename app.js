const express = require('express');
const app = express();
const port = 3000;

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));

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

app.get('/home', (req, res) => {
    res.render('home.ejs');
});

app.get('/patients', (req, res) => {
    res.render('patients.ejs');
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});