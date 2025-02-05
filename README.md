## Biometric Authentication in Flutter

This Flutter project implements biometric authentication using local_auth.

## Features

Authenticate users using biometric authentication (fingerprint/face ID).

Redirect users to the profile screen upon successful authentication.

## Dependencies

Ensure you have the following dependencies in your pubspec.yaml file:

dependencies:

```
  flutter:
    sdk: flutter
  local_auth: ^2.1.6
```

Setup Instructions

Clone the repository

```

git clone <repository_url>
cd <project_directory>
```

Install dependencies

```
flutter pub get

Run the application

flutter run
```

Android Configuration

Ensure you have the following permissions in AndroidManifest.xml:

```
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />

Inside <application> tag, add:

<meta-data 
    android:name="android.hardware.fingerprint" 
    android:value="true"/>
```

iOS Configuration

For iOS, add the following to ios/Runner/Info.plist:

```
<key>NSFaceIDUsageDescription</key>
<string>We need access to Face ID for authentication.</string>
```
