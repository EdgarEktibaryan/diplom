const express = require('express');
const app = express();

app.get('/', (req, res) => res.send('Version 1'));

module.exports = app;