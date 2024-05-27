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
    apiKey: 'AIzaSyAcGn8qPhwOnKiMvwc_m8GD-8-InbRweyg',
    appId: '1:655820254825:web:925f03337066310698fcf8',
    messagingSenderId: '655820254825',
    projectId: 'codingbryant-b3cb2',
    authDomain: 'codingbryant-b3cb2.firebaseapp.com',
    storageBucket: 'codingbryant-b3cb2.appspot.com',
    measurementId: 'G-0JF0MHFV7F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkq4QB5k-c-VIIoc20ebGgRzHV_8Qf3Ts',
    appId: '1:655820254825:android:51a6f5baa524f44498fcf8',
    messagingSenderId: '655820254825',
    projectId: 'codingbryant-b3cb2',
    storageBucket: 'codingbryant-b3cb2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBxrHTBM5Az2IGo5Ah-7SlY-O6yDrfED8',
    appId: '1:655820254825:ios:7b3e94e7096194fa98fcf8',
    messagingSenderId: '655820254825',
    projectId: 'codingbryant-b3cb2',
    storageBucket: 'codingbryant-b3cb2.appspot.com',
    iosBundleId: 'com.example.codingbryant',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBxrHTBM5Az2IGo5Ah-7SlY-O6yDrfED8',
    appId: '1:655820254825:ios:7b3e94e7096194fa98fcf8',
    messagingSenderId: '655820254825',
    projectId: 'codingbryant-b3cb2',
    storageBucket: 'codingbryant-b3cb2.appspot.com',
    iosBundleId: 'com.example.codingbryant',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAcGn8qPhwOnKiMvwc_m8GD-8-InbRweyg',
    appId: '1:655820254825:web:0c8d09ac5c22876a98fcf8',
    messagingSenderId: '655820254825',
    projectId: 'codingbryant-b3cb2',
    authDomain: 'codingbryant-b3cb2.firebaseapp.com',
    storageBucket: 'codingbryant-b3cb2.appspot.com',
    measurementId: 'G-VVLVRNP7E6',
  );
}
