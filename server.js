const fs = require('fs');
const express = require('express');
const bodyParser = require('body-parser');

const addon = require('./addon/build/Release/detect');

const app = express();

app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({
  limit: '50mb',
  extended: true
}));

app.post('/process', (req, res) => {

  const { images } = req.body;

  const base64Images = images.map(image => {
    let imageBuffer = decodeBase64Image(image.body);
    imageBuffer.data = addon.detect(imageBuffer.data);
    return new Buffer(imageBuffer.data).toString('base64');
  });

  res.send({ images: base64Images });

});

app.listen(3000, () => {
  console.log('Server started!');
});

// make nodejs package from this function
function decodeBase64Image(dataString) {
  var matches = dataString.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/),
    response = {};

  if (matches.length !== 3) {
    return new Error('Invalid input string');
  }

  response.type = matches[1];
  response.data = new Buffer(matches[2], 'base64');

  return response;
}
