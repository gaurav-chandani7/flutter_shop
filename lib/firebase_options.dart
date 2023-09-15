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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyA6yoBr2zxnM96pxcVND0qkPTWVKDucER8',
    appId: '1:468412142758:web:e607764341419ee3d3d067',
    messagingSenderId: '468412142758',
    projectId: 'flutter-shop-1122',
    authDomain: 'flutter-shop-1122.firebaseapp.com',
    storageBucket: 'flutter-shop-1122.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWXQxfjZXBTg8wxTYw846APOqiOvU9zyg',
    appId: '1:468412142758:android:691cd10c3ee7e977d3d067',
    messagingSenderId: '468412142758',
    projectId: 'flutter-shop-1122',
    storageBucket: 'flutter-shop-1122.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxLDImZ9_wjtgYwN5HeOS7_hRP4CyuuYE',
    appId: '1:468412142758:ios:a02415e161e389d5d3d067',
    messagingSenderId: '468412142758',
    projectId: 'flutter-shop-1122',
    storageBucket: 'flutter-shop-1122.appspot.com',
    iosBundleId: 'com.example.flutterShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxLDImZ9_wjtgYwN5HeOS7_hRP4CyuuYE',
    appId: '1:468412142758:ios:bebc8e33b4eb2563d3d067',
    messagingSenderId: '468412142758',
    projectId: 'flutter-shop-1122',
    storageBucket: 'flutter-shop-1122.appspot.com',
    iosBundleId: 'com.example.flutterShop.RunnerTests',
  );
}