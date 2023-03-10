// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDfaJ8MLxIoZLJr6nLFQrDcbMyVQGaFMpY',
    appId: '1:562270730217:web:100b3fd0ef1b60a9aafd78',
    messagingSenderId: '562270730217',
    projectId: 'ncert-be70c',
    authDomain: 'ncert-be70c.firebaseapp.com',
    storageBucket: 'ncert-be70c.appspot.com',
    measurementId: 'G-1WFT5V9EX0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCD4Ub_taN0Z52mk060r796W10JRy3c3jg',
    appId: '1:562270730217:android:19a55d73885034ccaafd78',
    messagingSenderId: '562270730217',
    projectId: 'ncert-be70c',
    storageBucket: 'ncert-be70c.appspot.com',
  );
}
