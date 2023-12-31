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
    apiKey: 'AIzaSyBFCFcW4VyILYhBo80Pn7boP5pqwGBCqVI',
    appId: '1:13526838296:web:fbc585e26e40d3c71ca76d',
    messagingSenderId: '13526838296',
    projectId: 'conversa-5354b',
    authDomain: 'conversa-5354b.firebaseapp.com',
    storageBucket: 'conversa-5354b.appspot.com',
    measurementId: 'G-VLGJB3761W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAt_enqdieEhO022Knxkw8DqtEjCIrEeo',
    appId: '1:13526838296:android:3e2e4a91e05b0b2c1ca76d',
    messagingSenderId: '13526838296',
    projectId: 'conversa-5354b',
    storageBucket: 'conversa-5354b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUJSKT5DYQmCiEVVhBIhxJpSCZfxGSw7Q',
    appId: '1:13526838296:ios:f1a51377c6aaa1ee1ca76d',
    messagingSenderId: '13526838296',
    projectId: 'conversa-5354b',
    storageBucket: 'conversa-5354b.appspot.com',
    iosClientId: '13526838296-2hjm8m43864bvbmeqaphijbmlh0tpdmk.apps.googleusercontent.com',
    iosBundleId: 'com.example.conversa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUJSKT5DYQmCiEVVhBIhxJpSCZfxGSw7Q',
    appId: '1:13526838296:ios:f1a51377c6aaa1ee1ca76d',
    messagingSenderId: '13526838296',
    projectId: 'conversa-5354b',
    storageBucket: 'conversa-5354b.appspot.com',
    iosClientId: '13526838296-2hjm8m43864bvbmeqaphijbmlh0tpdmk.apps.googleusercontent.com',
    iosBundleId: 'com.example.conversa',
  );
}
