cd libs/opencv && rm -rf release && mkdir release && cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=`pwd` ..
make -j4 && make install
cd ../../../addon && npm install && node-gyp configure && node-gyp build
