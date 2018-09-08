# SolidRock AppTemplate for iOS
This repository should serve as a starting point for new iOS Apps. Don't repeat yourself all the time.

## Configuration

The App configures itself thru the Info.plist file. The Info.plist file has a special feature supported by Xcode to inject variables during compilation time. This variables can be set in the Build Settings of the project and then are later specified with the $(MY_VARIABLE) syntax in the Info.plist. The big advantage - the Build Settings variables can be set different for each build configuration like Debug, Release, etc... In this way it get's really easy for example to configure everything which is specific to the build configuration. For example API Base URL's, API Keys, etc..


