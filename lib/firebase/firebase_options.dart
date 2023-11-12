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
    apiKey: 'AIzaSyA012_7YsL6vGebILbgcmV-uvdScR9vJa4',
    appId: '1:222546282714:web:d663885b1897dd16e4bde3',
    messagingSenderId: '222546282714',
    projectId: 'chat-app-cc6a3',
    authDomain: 'chat-app-cc6a3.firebaseapp.com',
    databaseURL: 'https://chat-app-cc6a3-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-cc6a3.appspot.com',
    measurementId: 'G-E2TLSSS8PW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGM4It2v26w3ZcNDSXVQpDDG8yyhpg9qs',
    appId: '1:222546282714:android:e3ad7ae19a09db62e4bde3',
    messagingSenderId: '222546282714',
    projectId: 'chat-app-cc6a3',
    databaseURL: 'https://chat-app-cc6a3-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-cc6a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyuo1a0mULP2GXTK6J37fb9D87u7dXwBc',
    appId: '1:222546282714:ios:65ffcfea2cd65bcee4bde3',
    messagingSenderId: '222546282714',
    projectId: 'chat-app-cc6a3',
    databaseURL: 'https://chat-app-cc6a3-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-cc6a3.appspot.com',
    iosBundleId: 'com.example.scholarChat',
  );
}