import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper
{
  static FirebaseHelper firebaseHelper = FirebaseHelper();

  FirebaseAuth auth = FirebaseAuth.instance;

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
}