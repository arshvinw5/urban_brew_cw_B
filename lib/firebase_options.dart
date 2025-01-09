// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        return windows;
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

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY_WEB'] ?? 'default_value',
    appId: dotenv.env['FIREBASE_APP_ID_WEB'] ?? 'default_value',
    messagingSenderId:
        dotenv.env['FIREBASE_MESSAGING_SENDER_ID_WEB'] ?? 'default_value',
    projectId: dotenv.env['FIREBASE_PROJECT_ID_WEB'] ?? 'default_value',
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_WEB'] ?? 'default_value',
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_WEB'] ?? 'default_value',
    measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID_WEB'] ?? 'default_value',
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY_ANDROID'] ?? 'default_value',
    appId: dotenv.env['FIREBASE_APP_ID_ANDROID'] ?? 'default_value',
    messagingSenderId:
        dotenv.env['FIREBASE_MESSAGING_SENDER_ID_ANDROID'] ?? 'default_value',
    projectId: dotenv.env['FIREBASE_PROJECT_ID_ANDROID'] ?? 'default_value',
    storageBucket:
        dotenv.env['FIREBASE_STORAGE_BUCKET_ANDROID'] ?? 'default_value',
  );

  static final FirebaseOptions windows = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY_UNKNOWN'] ?? 'default_value',
    appId: dotenv.env['FIREBASE_APP_ID_UNKNOWN'] ?? 'default_value',
    messagingSenderId:
        dotenv.env['FIREBASE_MESSAGING_SENDER_ID_UNKNOWN'] ?? 'default_value',
    projectId: dotenv.env['FIREBASE_PROJECT_ID_UNKNOWN'] ?? 'default_value',
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_UNKNOWN'] ?? 'default_value',
    storageBucket:
        dotenv.env['FIREBASE_STORAGE_BUCKET_UNKNOWN'] ?? 'default_value',
    measurementId:
        dotenv.env['FIREBASE_MEASUREMENT_ID_UNKNOWN'] ?? 'default_value',
  );
}