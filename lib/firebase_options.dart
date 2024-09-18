// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWppsjfMrYG3tIutEi8hdOXh5HYeLmlKw',
    appId: '1:567859055903:web:bb0c6dd85befd5cbd8742a',
    messagingSenderId: '567859055903',
    projectId: 'test-project-bca82',
    authDomain: 'test-project-bca82.firebaseapp.com',
    storageBucket: 'test-project-bca82.appspot.com',
    measurementId: 'G-M9LPZTZ4C7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAN3GN-4ZeSf6BfPhRSak-P3q8yJMdPrzw',
    appId: '1:567859055903:android:23a4674bbff2cee1d8742a',
    messagingSenderId: '567859055903',
    projectId: 'test-project-bca82',
    storageBucket: 'test-project-bca82.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6Igwq44iJRyp9oTlAvwD747Y2rKu-Eiw',
    appId: '1:567859055903:ios:d21c920b67a3ccf1d8742a',
    messagingSenderId: '567859055903',
    projectId: 'test-project-bca82',
    storageBucket: 'test-project-bca82.appspot.com',
    iosBundleId: 'com.example.astronacciTestApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6Igwq44iJRyp9oTlAvwD747Y2rKu-Eiw',
    appId: '1:567859055903:ios:d21c920b67a3ccf1d8742a',
    messagingSenderId: '567859055903',
    projectId: 'test-project-bca82',
    storageBucket: 'test-project-bca82.appspot.com',
    iosBundleId: 'com.example.astronacciTestApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWppsjfMrYG3tIutEi8hdOXh5HYeLmlKw',
    appId: '1:567859055903:web:13cb2249bf15c60ed8742a',
    messagingSenderId: '567859055903',
    projectId: 'test-project-bca82',
    authDomain: 'test-project-bca82.firebaseapp.com',
    storageBucket: 'test-project-bca82.appspot.com',
    measurementId: 'G-HPTRS3E0SD',
  );
}
