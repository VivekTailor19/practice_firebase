import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicefirebase/model/productModel.dart';
import 'package:practicefirebase/service/notification_Service.dart';

import '../../utils/firebase_helper.dart';

class UpdateItem_Screen extends StatefulWidget {
  const UpdateItem_Screen({super.key});

  @override
  State<UpdateItem_Screen> createState() => _UpdateItem_ScreenState();
}

class _UpdateItem_ScreenState extends State<UpdateItem_Screen> {

  String? gotId ;

  TextEditingController tname = TextEditingController();
  TextEditingController tprice = TextEditingController();
  TextEditingController tdescription = TextEditingController();
  TextEditingController tcategory = TextEditingController();
  TextEditingController timgUrl = TextEditingController();


  @override
  void initState() {
    super.initState();

    ProductModel model = Get.arguments;
    gotId = model.id;
    tname = TextEditingController(text: model.name);
    tprice = TextEditingController(text: model.price);
    tdescription = TextEditingController(text: model.description);
    tcategory = TextEditingController(text: model.category);
    timgUrl = TextEditingController(text: model.img);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          leading: Text(""),
          title: Text("Update Item"),
        backgroundColor: Color(0xff0A1172),

        centerTitle: true,),

        body: SingleChildScrollView(
          child: Column(
            children:[
              SizedBox(height: 15,),

              CustomTextField(hint: "Name",controller: tname,kboard: TextInputType.text),
              CustomTextField(hint: "Price",controller: tprice,kboard: TextInputType.number),
              CustomTextField(hint: "Category",controller: tcategory,kboard: TextInputType.text),
              CustomTextField(hint: "Description",controller: tdescription,kboard: TextInputType.text),
              CustomTextField(hint: "Image URL",controller: timgUrl,kboard: TextInputType.text),

              SizedBox(height: 15,),

              GestureDetector(
                onTap: () {
                  ProductModel model = ProductModel(
                    id: gotId!,
                      name: tname.text,
                      price: tprice.text,
                      category: tcategory.text,
                      description: tdescription.text,
                      img: timgUrl.text
                  );

                  FirebaseHelper.firebaseHelper.updateItem(model);

                  tname.clear();
                  tcategory.clear();
                  tdescription.clear();
                  tprice.clear();
                  timgUrl.clear();

                  NotificationService.service.timeNotification();


                  Get.back();

                //  Get.snackbar('Update', "Your Product Data is Updated in The Firebase CloudStore",snackPosition: SnackPosition.BOTTOM);

                },
                child: Container(height: 60,width: 120,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(0xff0A1172)),
                  alignment: Alignment.center,
                  child: Text("Add",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w300),),
                ),
              ),


            ],
          ),
        ),
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            label: Text("Product $hint",style: TextStyle(color: Color(0xff0A1172)),),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff0A1172),width: 1.3),borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0x550A1172),width: 1.3),borderRadius: BorderRadius.circular(10)),
            enabled: true

        ),
      ),
    );
  }
}
