const fs = require('fs');
const express = require('express');
const bodyParser = require('body-parser');

const addon = require('./addon/build/Release/detect');

const app = express();

app.use(bodyParser.json({ limit: '500mb' }));
app.use(bodyParser.urlencoded({
  limit: '500mb',
  extended: true
}));

let imageSent = false;

app.get('/', (req, res) => {
  res.send('It works');
});

app.post('/process', (req, res) => {

  console.log('request!');

  const { image, isLast } = req.body;

  let imageBuffer = decodeBase64Image(image.body);
  let obj = addon.detect(imageBuffer.data);
  let img = imageSent ? null : new Buffer(obj.image).toString('base64');

  res.send({
    left: {
      x: obj.lx,
      y: obj.ly
    },
    right: {
      x: obj.rx,
      y: obj.ry
    },
    image: img
  });

  if (isLast) {
    imageSent = false;
  } else {
    imageSent = true;
  }

});

app.listen(process.env.PORT || 5000, () => {
  console.log('Server started!');
});

app.on('error', (error) => {
  console.log('Error: ', error);
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
