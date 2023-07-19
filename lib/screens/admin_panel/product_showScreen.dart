import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practicefirebase/model/productModel.dart';
import 'package:practicefirebase/utils/firebase_helper.dart';
import 'package:sizer/sizer.dart';

class ProductListShow extends StatefulWidget {
  const ProductListShow({super.key});

  @override
  State<ProductListShow> createState() => _ProductListShowState();
}

class _ProductListShowState extends State<ProductListShow> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseHelper.firebaseHelper.readFireStore(),
      builder: (context, snapshot) {
      if(snapshot.hasError)
        {
          Center(child: Text("${snapshot.error}"));
        }
      else if(snapshot.hasData)
        {
          QuerySnapshot querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot> qdocsList = querySnapshot.docs;

          Map mapDATA = {};
          List<ProductModel> productItems = [];

          for(var temp in qdocsList)
            {
              mapDATA = temp.data() as Map ;
              String id = temp.id;
              String name = mapDATA['pname'];
              String category = mapDATA['pcategory'];
              String price = mapDATA['pprice'];
              String description = mapDATA['pdesc'];
              String img = mapDATA['pimg'];
              ProductModel model = ProductModel(id: id,category: category,name: name,description: description,price: price,img: img);
              productItems.add(model);
            }

          return ListView.builder(
            itemCount: productItems.length,
            itemBuilder: (context, index) {
              // print("productItems.length ===>>>>>>>>>>${productItems.length}");

              return Container(height: 150,width: 100.w,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(
                  0xffaaf3f2)),
              child: Row(children: [
                SizedBox(width: 10,),
                 ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(productItems[index].img != null ? "${productItems[index].img}": "https://images.freeimages.com/images/previews/ac9/railway-hdr-1361893.jpg",height: 135,width: 120,fit: BoxFit.contain,),),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                  Text("${productItems[index].name}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                  SizedBox(height: 15,),
                  Text("\$ ${productItems[index].price}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                  Spacer(),
                  Text("${productItems[index].category}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
                    SizedBox(height: 20,),
                ],)

              ],),);

          },
          );
        }
      return Center(child: CircularProgressIndicator());
    },);
  }
}
