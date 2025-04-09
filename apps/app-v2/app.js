const express = require('express');
const app = express();

app.get('/', (req, res) => res.send('Version 2'));

module.exports = app;