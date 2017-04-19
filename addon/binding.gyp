{
  "targets": [
    {
      "target_name": "detect",
      "sources": [ "detect.cpp", "./src/findEyeCorner.cpp", "./src/findEyeCenter.cpp", "./src/helpers.cpp"],
      "include_dirs": [
        "<!(node -e \"require('nan')\")",
        "../libs/opencv/release/include",
        "./src"
      ],
      'cflags!': ['-fno-exceptions', '-fno-rtti'],
      'cflags_cc!': ['-fno-exceptions', '-fno-rtti'],
      'conditions': [
        ['OS=="mac"', {
          'xcode_settings': {
            'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
	        'GCC_ENABLE_CPP_RTTI': 'YES',
          }
        }]
      ],
      "libraries": [
        "-L ../../libs/opencv/release/lib/",
        "-lopencv_calib3d",
        "-lopencv_contrib",
        "-lopencv_core",
        "-Wl,-rpath,../../libs/opencv/release/lib"
      ]
    }
  ]
}
