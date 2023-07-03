// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:orchids_emporium_vendors/vendor/views/auth/firebase_auth_ui_screen.dart';
import 'package:orchids_emporium_vendors/vendor/views/auth/vendor_auth.dart';
import 'package:orchids_emporium_vendors/vendor/views/auth/vendor_registration_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    PhoneAuthProvider(),
    GoogleProvider(clientId: '1:921101427915:android:2eb49101efe654a5c6674e'),
    //AppleProvider(),
    //FacebookProvider(clientId: FACEBOOK_CLIENT_ID),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Vendor App',
      debugShowCheckedModeBanner: false,
      //home: VendorRegistrationScreen(),
      //home: SignInScreen(),
      home: VendorAuthScreen(),
      builder: EasyLoading.init(),
    );
  }
}
