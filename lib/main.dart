import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicefirebase/firebase_options.dart';
import 'package:practicefirebase/screens/signIn.dart';
import 'package:practicefirebase/screens/signUp.dart';
import 'package:practicefirebase/screens/splashScreen.dart';
import 'package:practicefirebase/screens/welcome.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Sizer(builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/":(p0) => SplashScreen(),
          "/signUp":(p0) => Login_SignUp(),
          "/signIn":(p0) => Login_SignIn(),
          "/welcome":(p0) => Login_Welcome()
        },
      ),
    ),
  );
}
