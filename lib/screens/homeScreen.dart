import 'package:flutter/material.dart';
import 'package:practicefirebase/screens/admin_panel/addProductScreen.dart';
import 'package:practicefirebase/utils/firebase_helper.dart';
import 'package:sizer/sizer.dart';

import 'admin_panel/product_showScreen.dart';

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
      child: DefaultTabController(
        length: 2,


        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(child: Text("Add Product"),),
              Tab(child: Text("Products"),),
            ]),
          ),
          drawer: Drawer(
            backgroundColor: Color(0xff0A1172),
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

          body: TabBarView(
            children: [
              Add_Product_Screen(),
              ProductListShow()
            ],
          ),


        ),
      ),
    );
  }
}
