import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicefirebase/model/productModel.dart';

import '../../utils/firebase_helper.dart';

class Add_Product_Screen extends StatefulWidget {
  const Add_Product_Screen({super.key});

  @override
  State<Add_Product_Screen> createState() => _Add_Product_ScreenState();
}

class _Add_Product_ScreenState extends State<Add_Product_Screen> {

  TextEditingController tname = TextEditingController();
  TextEditingController tprice = TextEditingController();
  TextEditingController tdescription = TextEditingController();
  TextEditingController tcategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:[

          CustomTextField(hint: "Name",controller: tname,kboard: TextInputType.text),
          CustomTextField(hint: "Price",controller: tprice,kboard: TextInputType.number),
          CustomTextField(hint: "Category",controller: tcategory,kboard: TextInputType.text),
          CustomTextField(hint: "Description",controller: tdescription,kboard: TextInputType.text),

          SizedBox(height: 15,),

          GestureDetector(
            onTap: () {
              ProductModel model = ProductModel(
                name: tname.text,
                price: tprice.text,
                category: tcategory.text,
                description: tdescription.text
              );

              FirebaseHelper.firebaseHelper.addInFireStore(model);

              tname.clear();
              tcategory.clear();
              tdescription.clear();
              tprice.clear();

              Get.snackbar('Update', "Your Product Data is Updated in The Firebase CloudStore",snackPosition: SnackPosition.BOTTOM);


            },
            child: Container(height: 60,width: 120,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(0xff0A1172)),
              alignment: Alignment.center,
              child: Text("Add",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w300),),
            ),
          ),


        ],
      ),
    );
  }

  Padding CustomTextField({controller,hint,kboard}) {
    return Padding(
        padding:  EdgeInsets.all(10),
        child: TextField(
          style: TextStyle(color: Color(0xff0A1172),fontSize: 16),
          keyboardType: kboard,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
            label: Text("Product $hint",style: TextStyle(color: Color(0xff0A1172)),),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0A1172),width: 1.3),borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0x550A1172),width: 1.3),borderRadius: BorderRadius.circular(10)),
            enabled: true

          ),
        ),
      );
  }
}
