import 'package:flutter/material.dart';
import 'package:practicefirebase/utils/firebase_helper.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map mapData = {};

  @override
  void initState() {
    super.initState();
    mapData = FirebaseHelper.firebaseHelper.readUser();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          backgroundColor: Color(0xff51B5FF),
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 65,backgroundImage: NetworkImage("${mapData['photo']}"),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${mapData['name']}",style: TextStyle(color: Colors.white,fontSize: 25.sp),),
                ),
                Text("${mapData['email']}",style: TextStyle(color: Colors.white,fontSize: 14.sp),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
