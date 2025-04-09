const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Version 1</title>
        <style>
          body {
            margin: 0;
            background-color:rgb(80, 187, 47);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            color: white;
          }
          h1 {
            font-size: 5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
          }
        </style>
      </head>
      <body>
        <h1>Version 1</h1>
      </body>
    </html>
  `);
});

module.exports = app;
