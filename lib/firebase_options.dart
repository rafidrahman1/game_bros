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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEhVyPLBGsk1r8Fc4HGYwh9mKO_y0sUco',
    appId: '1:903938828191:android:51b2cc1f2cde30d6197faa',
    messagingSenderId: '903938828191',
    projectId: 'game-bros-f6caf',
    storageBucket: 'game-bros-f6caf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9LpJaK-6P7f6t8JsNABISusAJAP_CZhI',
    appId: '1:903938828191:ios:da501fd567e26836197faa',
    messagingSenderId: '903938828191',
    projectId: 'game-bros-f6caf',
    storageBucket: 'game-bros-f6caf.appspot.com',
    androidClientId: '903938828191-magu2ofhv88jo94bf3sqgo2qr21p6o51.apps.googleusercontent.com',
    iosClientId: '903938828191-jaj517a2i0c63qrptkjm4aen5ha889pg.apps.googleusercontent.com',
    iosBundleId: 'com.example.gameBros',
  );
}
