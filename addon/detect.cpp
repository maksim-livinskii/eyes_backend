#include <iostream>
#include <vector>

#include <nan.h>

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/opencv.hpp>

#include "./src/constants.h"
#include "./src/findEyeCenter.h"
#include "./src/findEyeCorner.h"

struct Eye {
  Eye():x(0),y(0) {}
  Eye(float d):x(d),y(d) {}
  Eye(float x, float y) {
    this->x = x;
    this->y = y;
  }
  float x;
  float y;
};

bool process(cv::Mat& image, std::pair<Eye, Eye>&);

std::pair<Eye, Eye> findEyes(cv::Mat& image, cv::Mat frame_gray, cv::Rect face);

cv::CascadeClassifier face_cascade;

void Detect(const Nan::FunctionCallbackInfo<v8::Value>& info) {

  v8::Isolate* isolate = info.GetIsolate();

  if (info.Length() != 1) {
    Nan::ThrowTypeError("Wrong number of arguments");
    return;
  }

  v8::Local<v8::Object> bufferObj = info[0]->ToObject();

  char* bufferData = node::Buffer::Data(bufferObj);
  size_t bufferLength = node::Buffer::Length(bufferObj);

  std::vector<char> jpgbytes(bufferData, bufferData + bufferLength); // from your db
  cv::Mat img = cv::imdecode(jpgbytes, CV_LOAD_IMAGE_COLOR);

  // cv::imshow("img", img);
  // cv::waitKey(0);

  cv::transpose(img, img);
  cv::flip(img, img, 1);

  std::pair<Eye, Eye> res;

  process(img, res);

  std::vector<uchar> buf;
  cv::imencode(".jpg", img, buf);

  auto image = Nan::CopyBuffer((char*)buf.data(), buf.size()).ToLocalChecked();

  v8::Local<v8::Object> obj = v8::Object::New(isolate);
  obj->Set(v8::String::NewFromUtf8(isolate, "lx"), v8::Number::New(isolate, res.first.x)); // left
  obj->Set(v8::String::NewFromUtf8(isolate, "ly"), v8::Number::New(isolate, res.first.y)); // left
  obj->Set(v8::String::NewFromUtf8(isolate, "rx"), v8::Number::New(isolate, res.second.x)); // right
  obj->Set(v8::String::NewFromUtf8(isolate, "ry"), v8::Number::New(isolate, res.second.y)); // right
  obj->Set(v8::String::NewFromUtf8(isolate, "image"), image);

  info.GetReturnValue().Set(obj);

}

bool process(cv::Mat& image, std::pair<Eye, Eye>& eyes) {
  std::vector<cv::Rect> faces;

  std::vector<cv::Mat> rgbChannels(3);
  cv::split(image, rgbChannels);
  cv::Mat image_gray = rgbChannels[2];

  // Detect faces
  face_cascade.detectMultiScale(image_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE|CV_HAAR_FIND_BIGGEST_OBJECT);

  for(std::size_t i = 0; i < faces.size(); i++) {
    rectangle(image, faces[i], 1234, 3);
  }

  createCornerKernels();

  if (faces.size() == 1) {
    eyes = findEyes(image, image_gray, faces[0]);
  } else {
    return false;
  }

  releaseCornerKernels();

  return true;
}

std::pair<Eye, Eye> findEyes(cv::Mat& image, cv::Mat frame_gray, cv::Rect face) {
  cv::Mat faceROI = frame_gray(face);
  cv::Mat debugFace = faceROI;

  if (kSmoothFaceImage) {
    double sigma = kSmoothFaceFactor * face.width;
    GaussianBlur( faceROI, faceROI, cv::Size( 0, 0 ), sigma);
  }

  //-- Find eye regions and draw them
  int eye_region_width = face.width * (kEyePercentWidth / 100.0);
  int eye_region_height = face.width * (kEyePercentHeight / 100.0);
  int eye_region_top = face.height * (kEyePercentTop / 100.0);

  cv::Rect leftEyeRegion(face.width * (kEyePercentSide / 100.0),
                         eye_region_top, eye_region_width, eye_region_height);
  cv::Rect rightEyeRegion(face.width - eye_region_width - face.width * (kEyePercentSide / 100.0),
                          eye_region_top, eye_region_width, eye_region_height);

  //-- Find Eye Centers
  cv::Point leftPupil = findEyeCenter(faceROI, leftEyeRegion, "Left Eye");
  cv::Point rightPupil = findEyeCenter(faceROI, rightEyeRegion, "Right Eye");

  // get corner regions
  cv::Rect leftRightCornerRegion(leftEyeRegion);
  leftRightCornerRegion.width -= leftPupil.x;
  leftRightCornerRegion.x += leftPupil.x;
  leftRightCornerRegion.height /= 2;
  leftRightCornerRegion.y += leftRightCornerRegion.height / 2;

  cv::Rect leftLeftCornerRegion(leftEyeRegion);
  leftLeftCornerRegion.width = leftPupil.x;
  leftLeftCornerRegion.height /= 2;
  leftLeftCornerRegion.y += leftLeftCornerRegion.height / 2;

  cv::Rect rightLeftCornerRegion(rightEyeRegion);
  rightLeftCornerRegion.width = rightPupil.x;
  rightLeftCornerRegion.height /= 2;
  rightLeftCornerRegion.y += rightLeftCornerRegion.height / 2;

  cv::Rect rightRightCornerRegion(rightEyeRegion);
  rightRightCornerRegion.width -= rightPupil.x;
  rightRightCornerRegion.x += rightPupil.x;
  rightRightCornerRegion.height /= 2;
  rightRightCornerRegion.y += rightRightCornerRegion.height / 2;

  // eyes corners
  // cv::Point leftRightCorner = findEyeCorner(faceROI(leftRightCornerRegion), true, false);
  // leftRightCorner.x += leftRightCornerRegion.x;
  // leftRightCorner.y += leftRightCornerRegion.y;
  //
  // cv::Point2f leftLeftCorner = findEyeCorner(faceROI(leftLeftCornerRegion), true, true);
  // leftLeftCorner.x += leftLeftCornerRegion.x;
  // leftLeftCorner.y += leftLeftCornerRegion.y;
  //
  // cv::Point2f rightLeftCorner = findEyeCorner(faceROI(rightLeftCornerRegion), false, true);
  // rightLeftCorner.x += rightLeftCornerRegion.x;
  // rightLeftCorner.y += rightLeftCornerRegion.y;
  //
  // cv::Point2f rightRightCorner = findEyeCorner(faceROI(rightRightCornerRegion), false, false);
  // rightRightCorner.x += rightRightCornerRegion.x;
  // rightRightCorner.y += rightRightCornerRegion.y;

  // change eye centers to face coordinates
  rightPupil.x += rightEyeRegion.x + face.x;
  rightPupil.y += rightEyeRegion.y + face.y;
  leftPupil.x += leftEyeRegion.x + face.x;
  leftPupil.y += leftEyeRegion.y + face.y;

  leftRightCornerRegion.x += face.x;
  leftRightCornerRegion.y += face.y;

  leftLeftCornerRegion.x += face.x;
  leftLeftCornerRegion.y += face.y;

  rightLeftCornerRegion.x += face.x;
  rightLeftCornerRegion.y += face.y;

  rightRightCornerRegion.x += face.x;
  rightRightCornerRegion.y += face.y;

  // leftRightCorner.x += face.x;
  // leftRightCorner.y += face.y;
  //
  // leftLeftCorner.x += face.x;
  // leftLeftCorner.y += face.y;
  //
  // rightLeftCorner.x += face.x;
  // rightLeftCorner.y += face.y;
  //
  // rightRightCorner.x += face.x;
  // rightRightCorner.y += face.y;

  circle(image, rightPupil, 5, 1234, 5);
  circle(image, leftPupil, 5, 1234, 5);

  rectangle(image, leftRightCornerRegion, 200, 2);
  rectangle(image, leftLeftCornerRegion, 200, 2);
  rectangle(image, rightLeftCornerRegion, 200, 2);
  rectangle(image, rightRightCornerRegion, 200, 2);

  // circle(image, leftRightCorner, 3, 200, 3);
  // circle(image, leftLeftCorner, 3, 200, 3);
  // circle(image, rightLeftCorner, 3, 200, 3);
  // circle(image, rightRightCorner, 3, 200, 3);

  return std::make_pair(Eye(leftPupil.x, leftPupil.y), Eye(rightPupil.x, rightPupil.y));

}

void Init(v8::Local<v8::Object> exports) {

  cv::String face_cascade_name = "./addon/res/haarcascade_frontalface_alt.xml";
  if (!face_cascade.load(face_cascade_name)) {
    std::cerr << "--(!)Error loading face cascade, please change face_cascade_name in source code.\n" << std::endl;
    return;
  }

  exports->Set(
    Nan::New("detect").ToLocalChecked(),
    Nan::New<v8::FunctionTemplate>(Detect)->GetFunction()
  );
}

NODE_MODULE(detect, Init)
