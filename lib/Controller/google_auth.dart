import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notesapp/Screen/homeScreen.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<bool> signInWithGoogle(BuildContext context) async {
  try{
    final GoogleSignInAccount signInAccount = await googleSignIn.signIn();

    if (signInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await signInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      final UserCredential authResult =
        await auth.signInWithCredential(credential);

      print(authResult);

      final User user = authResult.user;

      var userData = {
        'name': signInAccount.displayName,
        'email': signInAccount.email,
        'photoUrl': signInAccount.photoUrl,
        'provider': 'google'
      };

      users.doc(user.uid).get().then((doc) async{

        print(doc.exists.toString() + 'this the doc');
        if (doc.exists) {
          // old User
          doc.reference.update(userData);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
          
        }else {
          // new User
          await users.doc(user.uid).set(userData);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())
          );
        }
      }
      );
    }

  } catch(PlatformException) {
    print(PlatformException);
    print('Sign in unsucessful');
  }
}