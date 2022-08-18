# Demo App for ActiveLook glasses

## What is the purpose of this app ?

This app allows you to scan, connect and tests differents commands on your glasses.

## How to compile the app ?

Android : Create a .env file at the root of the demo-app project folder. This file should contain the two lines below.

```java
ACTIVELOOK_SDK_TOKEN = "<YOUR_TOKEN>"
ACTIVELOOK_CFG_PASSWORD = <0xDEADBEEF> //The ActiveLook config password, if needed
```

Open the "android" folder with android studio. Connect a phone an launch the app


iOS : Create a file Config.xcconfig in the ios folder with the informations below (don't put " " for iOS token)

```swift
ACTIVELOOK_SDK_TOKEN = <YOUR_TOKEN>
ACTIVELOOK_CFG_PASSWORD = <0xDEADBEEF> //The ActiveLook config password, if needed
```

Open the "ios" folder with Xcode. Connect a ios phone an launch the app
