cmd_Release/obj.target/detect.node := g++ -shared -pthread -rdynamic -m64  -Wl,-soname=detect.node -o Release/obj.target/detect.node -Wl,--start-group Release/obj.target/detect/detect.o Release/obj.target/detect/src/findEyeCorner.o Release/obj.target/detect/src/findEyeCenter.o Release/obj.target/detect/src/helpers.o -Wl,--end-group -L ../../libs/opencv/release/lib/ -lopencv_calib3d -lopencv_contrib -lopencv_core -Wl,-rpath,../../libs/opencv/release/lib
