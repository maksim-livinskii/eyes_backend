cmd_Release/obj.target/detect/detect.o := g++ '-DNODE_GYP_MODULE_NAME=detect' '-DUSING_UV_SHARED=1' '-DUSING_V8_SHARED=1' '-DV8_DEPRECATION_WARNINGS=1' '-D_LARGEFILE_SOURCE' '-D_FILE_OFFSET_BITS=64' '-DBUILDING_NODE_EXTENSION' -I/app/.node-gyp/6.10.2/include/node -I/app/.node-gyp/6.10.2/src -I/app/.node-gyp/6.10.2/deps/uv/include -I/app/.node-gyp/6.10.2/deps/v8/include -I../node_modules/nan -I/app/release/include -I../src  -fPIC -pthread -Wall -Wextra -Wno-unused-parameter -m64 -O3 -fno-omit-frame-pointer -std=gnu++0x -MMD -MF ./Release/.deps/Release/obj.target/detect/detect.o.d.raw   -c -o Release/obj.target/detect/detect.o ../detect.cpp
Release/obj.target/detect/detect.o: ../detect.cpp \
 ../node_modules/nan/nan.h \
 /app/.node-gyp/6.10.2/include/node/node_version.h \
 /app/.node-gyp/6.10.2/include/node/uv.h \
 /app/.node-gyp/6.10.2/include/node/uv-errno.h \
 /app/.node-gyp/6.10.2/include/node/uv-version.h \
 /app/.node-gyp/6.10.2/include/node/uv-unix.h \
 /app/.node-gyp/6.10.2/include/node/uv-threadpool.h \
 /app/.node-gyp/6.10.2/include/node/uv-linux.h \
 /app/.node-gyp/6.10.2/include/node/node.h \
 /app/.node-gyp/6.10.2/include/node/v8.h \
 /app/.node-gyp/6.10.2/include/node/v8-version.h \
 /app/.node-gyp/6.10.2/include/node/v8config.h \
 /app/.node-gyp/6.10.2/include/node/node_version.h \
 /app/.node-gyp/6.10.2/include/node/node_buffer.h \
 /app/.node-gyp/6.10.2/include/node/node.h \
 /app/.node-gyp/6.10.2/include/node/node_object_wrap.h \
 ../node_modules/nan/nan_callbacks.h \
 ../node_modules/nan/nan_callbacks_12_inl.h \
 ../node_modules/nan/nan_maybe_43_inl.h \
 ../node_modules/nan/nan_converters.h \
 ../node_modules/nan/nan_converters_43_inl.h \
 ../node_modules/nan/nan_new.h \
 ../node_modules/nan/nan_implementation_12_inl.h \
 ../node_modules/nan/nan_persistent_12_inl.h \
 ../node_modules/nan/nan_weak.h ../node_modules/nan/nan_object_wrap.h \
 ../node_modules/nan/nan_private.h \
 ../node_modules/nan/nan_typedarray_contents.h \
 ../node_modules/nan/nan_json.h \
 /app/release/include/opencv2/imgproc/imgproc.hpp \
 /app/release/include/opencv2/core/core.hpp \
 /app/release/include/opencv2/core/types_c.h \
 /app/release/include/opencv2/core/version.hpp \
 /app/release/include/opencv2/core/operations.hpp \
 /app/release/include/opencv2/core/mat.hpp \
 /app/release/include/opencv2/imgproc/types_c.h \
 /app/release/include/opencv2/core/core_c.h \
 /app/release/include/opencv2/opencv.hpp \
 /app/release/include/opencv2/opencv_modules.hpp \
 /app/release/include/opencv2/flann/miniflann.hpp \
 /app/release/include/opencv2/flann/defines.h \
 /app/release/include/opencv2/flann/config.h \
 /app/release/include/opencv2/imgproc/imgproc_c.h \
 /app/release/include/opencv2/photo/photo.hpp \
 /app/release/include/opencv2/photo/photo_c.h \
 /app/release/include/opencv2/video/video.hpp \
 /app/release/include/opencv2/video/tracking.hpp \
 /app/release/include/opencv2/video/background_segm.hpp \
 /app/release/include/opencv2/features2d/features2d.hpp \
 /app/release/include/opencv2/objdetect/objdetect.hpp \
 /app/release/include/opencv2/calib3d/calib3d.hpp \
 /app/release/include/opencv2/core/affine.hpp \
 /app/release/include/opencv2/ml/ml.hpp \
 /app/release/include/opencv2/highgui/highgui_c.h \
 /app/release/include/opencv2/highgui/highgui.hpp \
 /app/release/include/opencv2/contrib/contrib.hpp \
 /app/release/include/opencv2/contrib/retina.hpp \
 /app/release/include/opencv2/contrib/openfabmap.hpp .././src/constants.h \
 .././src/findEyeCenter.h .././src/findEyeCorner.h
../detect.cpp:
../node_modules/nan/nan.h:
/app/.node-gyp/6.10.2/include/node/node_version.h:
/app/.node-gyp/6.10.2/include/node/uv.h:
/app/.node-gyp/6.10.2/include/node/uv-errno.h:
/app/.node-gyp/6.10.2/include/node/uv-version.h:
/app/.node-gyp/6.10.2/include/node/uv-unix.h:
/app/.node-gyp/6.10.2/include/node/uv-threadpool.h:
/app/.node-gyp/6.10.2/include/node/uv-linux.h:
/app/.node-gyp/6.10.2/include/node/node.h:
/app/.node-gyp/6.10.2/include/node/v8.h:
/app/.node-gyp/6.10.2/include/node/v8-version.h:
/app/.node-gyp/6.10.2/include/node/v8config.h:
/app/.node-gyp/6.10.2/include/node/node_version.h:
/app/.node-gyp/6.10.2/include/node/node_buffer.h:
/app/.node-gyp/6.10.2/include/node/node.h:
/app/.node-gyp/6.10.2/include/node/node_object_wrap.h:
../node_modules/nan/nan_callbacks.h:
../node_modules/nan/nan_callbacks_12_inl.h:
../node_modules/nan/nan_maybe_43_inl.h:
../node_modules/nan/nan_converters.h:
../node_modules/nan/nan_converters_43_inl.h:
../node_modules/nan/nan_new.h:
../node_modules/nan/nan_implementation_12_inl.h:
../node_modules/nan/nan_persistent_12_inl.h:
../node_modules/nan/nan_weak.h:
../node_modules/nan/nan_object_wrap.h:
../node_modules/nan/nan_private.h:
../node_modules/nan/nan_typedarray_contents.h:
../node_modules/nan/nan_json.h:
/app/release/include/opencv2/imgproc/imgproc.hpp:
/app/release/include/opencv2/core/core.hpp:
/app/release/include/opencv2/core/types_c.h:
/app/release/include/opencv2/core/version.hpp:
/app/release/include/opencv2/core/operations.hpp:
/app/release/include/opencv2/core/mat.hpp:
/app/release/include/opencv2/imgproc/types_c.h:
/app/release/include/opencv2/core/core_c.h:
/app/release/include/opencv2/opencv.hpp:
/app/release/include/opencv2/opencv_modules.hpp:
/app/release/include/opencv2/flann/miniflann.hpp:
/app/release/include/opencv2/flann/defines.h:
/app/release/include/opencv2/flann/config.h:
/app/release/include/opencv2/imgproc/imgproc_c.h:
/app/release/include/opencv2/photo/photo.hpp:
/app/release/include/opencv2/photo/photo_c.h:
/app/release/include/opencv2/video/video.hpp:
/app/release/include/opencv2/video/tracking.hpp:
/app/release/include/opencv2/video/background_segm.hpp:
/app/release/include/opencv2/features2d/features2d.hpp:
/app/release/include/opencv2/objdetect/objdetect.hpp:
/app/release/include/opencv2/calib3d/calib3d.hpp:
/app/release/include/opencv2/core/affine.hpp:
/app/release/include/opencv2/ml/ml.hpp:
/app/release/include/opencv2/highgui/highgui_c.h:
/app/release/include/opencv2/highgui/highgui.hpp:
/app/release/include/opencv2/contrib/contrib.hpp:
/app/release/include/opencv2/contrib/retina.hpp:
/app/release/include/opencv2/contrib/openfabmap.hpp:
.././src/constants.h:
.././src/findEyeCenter.h:
.././src/findEyeCorner.h:
