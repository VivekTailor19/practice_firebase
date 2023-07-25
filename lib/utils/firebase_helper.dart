import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practicefirebase/model/productModel.dart';
import 'package:practicefirebase/service/notification_Service.dart';

class FirebaseHelper
{
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> anonymous_login()
  async {
    try
    {
      await auth.signInAnonymously();
      return "Success";
    }
    catch(e)
    {
      return "$e";
    }
  }

  bool check_user()
  {
    User? user=auth.currentUser;
    return user!=null;
  }


  Future<void> user_logout()
  async {
    await auth.signOut();
    GoogleSignIn().signOut();
  }

  Future<UserCredential> googleLogin()
  async {

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
      }

  Future<String> emailSignUp({email,password})
  async {

try{
  await auth.createUserWithEmailAndPassword(email: email, password: password);
  return "Success";
}catch(e)
    {
      return "$e";
    }

  }

  Future<String> emailSignIn({email,password})
  async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    }catch(e)
    {
      return "$e";
    }
  }

  Map<String, String?> readUser()
    {
        User? user = auth.currentUser;

        return {
          'email':user!.email,
          'name':user.displayName,
          'photo':user.photoURL
        };
      }
      
      
      
/*  ======================FireBase FireStore =============================================== */

  
  void addInFireStore(ProductModel model)
  {
    firestore.collection("ShoppingStore").add({
      "pname":model.name,
      "pprice":model.price,
      "pcategory":model.category,
      "pdesc":model.description,
      "pimg":model.img
    });
  
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> readFireStore()
  {
    return firestore.collection("ShoppingStore").snapshots();
  }


  void deleteItem(String id)
  {
    firestore.collection("ShoppingStore").doc(id).delete();
  }

  void updateItem(ProductModel model)
  {
    firestore.collection("ShoppingStore").doc(model.id).set({
      "pname":model.name,
      "pprice":model.price,
      "pcategory":model.category,
      "pdesc":model.description,
      "pimg":model.img
    });
  }



  // =========================    firestore messaging ====================================

Future<void> initMessaging()
async {
  final fcmToken = await FirebaseMessaging.instance.getToken();

  print("Token ====  $fcmToken");

  FirebaseMessaging.onMessage.listen((msg) {
    var notify = msg.notification;

    if(notify!=null)
      {
        var title = notify.title;
        var body = notify.body;

        NotificationService.service.fireNotification(title: title,body: body);
      }
  });
}


}