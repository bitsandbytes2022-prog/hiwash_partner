import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    /*  case TargetPlatform.iOS:
        return ios;*/
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeE04laXbAPJe0uTPa5H7o87VVB1HPdY8',
    appId: '1:771921395674:android:5e8f9aaf5ba0df89d9cae3',
    messagingSenderId: '771921395674',
    projectId: 'self-service-iphone',
    storageBucket: 'self-service-iphone.firebasestorage.app',
  );

/*  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA...yourIosKey...',
    appId: '1:1234567890:ios:abcdef123456',
    messagingSenderId: '1234567890',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.example.youriosapp',
  );*/
}
