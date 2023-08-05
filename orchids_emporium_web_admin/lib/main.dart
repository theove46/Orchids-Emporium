import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium_web_admin/views/screens/main_screen.dart';

// Show images on web, run this command on termnal:
// flutter run -d chrome --web-port=8080  --web-renderer html

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? FirebaseOptions(
            apiKey: "AIzaSyDm9pLGSRJUfdtnD_FC05dKmnwZjs-F1Pw",
            appId: "1:921101427915:web:fc650ffbaccda75fc6674e",
            messagingSenderId: "921101427915",
            projectId: "orchids-emporium",
            storageBucket: "orchids-emporium.appspot.com",
          )
        : null,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    return MaterialApp(
      title: 'Orchids Emporium Admin panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
