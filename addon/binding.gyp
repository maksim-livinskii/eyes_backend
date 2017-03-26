{
  "targets": [
    {
      "target_name": "detect",
      "sources": [ "detect.cpp", "./src/findEyeCorner.cpp", "./src/findEyeCenter.cpp", "./src/helpers.cpp"],
      "include_dirs": [
        "<!(node -e \"require('nan')\")",
        "/usr/local/include",
        "./src"
      ],
      "libraries": [
        "-L/usr/local/lib", "-lopencv_calib3d", "-lopencv_contrib", "-lopencv_core"
      ]
    }
  ]
}
