import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicefirebase/utils/firebase_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool userStatus = false;
  @override
  void initState() {
    super.initState();

    userStatus = FirebaseHelper.firebaseHelper.check_user();
  }

  @override
  Widget build(BuildContext context) {


    Future.delayed(Duration(seconds: 3),() =>
    userStatus == false
        ? Get.offAllNamed("/signIn")
        : Get.offAllNamed("/welcome"));

    return SafeArea(
      child: Scaffold(
        body: Center(child: FlutterLogo(size: 150,style: FlutterLogoStyle.stacked),),
      ),
    );
  }
}
