import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:orchids_emporium/users/view/auth/login_screen.dart';
import 'package:orchids_emporium/users/view/screens/main_user_screen.dart';
import 'package:orchids_emporium/vendor/views/auth/firebase_auth_ui_screen.dart';
import 'package:orchids_emporium/vendor/views/auth/vendor_auth.dart';
import 'package:orchids_emporium/vendor/views/auth/vendor_registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:orchids_emporium/vendor/views/screens/main_vendor_screen.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return ProductProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CartProvider();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    return ScreenUtilInit(
        designSize: const Size(428.0, 926.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Orchids Emporium',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            home: const MainUserScreen(),
            //home: const MainVendorScreen(),
            //home: const LoginScreen(),
            //home: const VendorAuthScreen(),
          );
        });
  }
}
