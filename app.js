const express = require('express');
const app = express();
const port = 3000;

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.render('main.ejs', {username: 'Guest'});
});

app.post('/greet', (req, res) => {
    const { username } = req.body;
    res.render('main.ejs', { username });
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});