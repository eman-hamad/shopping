## Flutter Beta Testing with Firebase App Distribution
This guide helps you set up Firebase App Distribution to conduct beta testing for your Flutter app.

## Steps for Setup
1. Set Up Firebase Project
Go to the Firebase Console, create or use an existing Firebase project.
Add your Android and iOS apps in the Firebase Console:
For Android, use the package name from android/app/build.gradle.
For iOS, use the iOS bundle ID.
2. Add Firebase SDK to Flutter App
In your pubspec.yaml, add the necessary Firebase dependencies:
yaml

```

dependencies:
  firebase_core: ^1.10.0
  firebase_app_distribution: ^1.0.0

```

Run flutter pub get to install the packages.
3. Configure Firebase for Android
Download google-services.json from the Firebase Console and place it in android/app/.
Update android/build.gradle:
gradle

```
classpath 'com.google.gms:google-services:4.3.15'
```

In android/app/build.gradle, add:
gradle

apply plugin: 'com.google.gms.google-services'
Ensure that firebase_app_distribution is added as a dependency:
gradle

```

dependencies {
  implementation 'com.google.firebase:firebase-appdistribution:3.0.0'
}
```

4. Configure Firebase for iOS
Download GoogleService-Info.plist from the Firebase Console.
Add the file to your Xcode project (inside ios/Runner).
In your ios/Podfile, add:

```
pod 'Firebase/Core'
pod 'Firebase/AppDistribution'
Run pod install from the ios/ directory.
```

5. Initialize Firebase in Flutter
In your main.dart:


```
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_distribution/firebase_app_distribution.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

6. Check for Updates in App (Optional)
Optionally, prompt users to update the app if a new version is available:

```
void checkForUpdate() async {
  final result = await FirebaseAppDistribution.instance.checkForUpdate();
  if (result.updateAvailable) {
    // Show update notification to the user
  }
}
```

7. Build Your APK/IPA
For Android: Run flutter build apk.
For iOS: Run flutter build ios and use Xcode to archive.
8. Distribute to Testers
Go to the Firebase Console → App Distribution.
Upload your APK (Android) or IPA (iOS).
Add testers by email or upload a CSV of email addresses.
Firebase will send testers invitations to download the app.
9. Collect Feedback
Use the Firebase Console to monitor feedback, crash reports, and analytics.


![test1](https://github.com/user-attachments/assets/0ae4d0f9-157d-46d1-87b7-f996fbf3158e)

![test2](https://github.com/user-attachments/assets/bb1a99a6-b458-49f5-802a-acfb5f6b7a85)

![WhatsApp Image 2025-02-19 at 10 35 21 PM (1)](https://github.com/user-attachments/assets/9d0ad781-db72-4087-b5b9-a20a3c43f075)

![WhatsApp Image 2025-02-19 at 10 35 22 PM (2)](https://github.com/user-attachments/assets/93335e46-862f-401a-bd93-e5783b8e4f79)

![WhatsApp Image 2025-02-19 at 10 35 23 PM (2)](https://github.com/user-attachments/assets/160c94aa-a6e1-47f9-bd53-9d0a7c72bb1c)

![WhatsApp Image 2025-02-19 at 10 35 23 PM](https://github.com/user-attachments/assets/8935c172-96aa-4ac7-9d72-a68787cb90fd)

![WhatsApp Image 2025-02-19 at 10 35 23 PM (1)](https://github.com/user-attachments/assets/cf9b493d-b77f-44d9-9f74-897aff607504)

![WhatsApp Image 2025-02-19 at 10 35 21 PM](https://github.com/user-attachments/assets/63a07f8d-cbe5-47d4-a273-f4cacb1d5dd7)

![WhatsApp Image 2025-02-19 at 10 35 21 PM (2)](https://github.com/user-attachments/assets/870f7e8b-5fe4-4759-909d-967b74349d35)

![WhatsApp Image 2025-02-19 at 10 35 20 PM](https://github.com/user-attachments/assets/c6cf2a3a-b11b-489a-9957-1f6268cefd8c)

![WhatsApp Image 2025-02-19 at 10 35 22 PM](https://github.com/user-attachments/assets/30614342-1f7f-4875-9385-2653fbe466cf)
