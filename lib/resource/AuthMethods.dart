import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:video_chat/Utility/utils.dart'; // Make sure this is the correct path for your showSnackBar function

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authChanges => _auth.authStateChanges();

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          // If the user is new, save additional details to Firestore
          if (userCredential.additionalUserInfo!.isNewUser) {
            await _firestore.collection('users').doc(user.uid).set({
              'username': user.displayName,
              'uid': user.uid,
              'profilePhoto': user.photoURL,
            });
          }
          res = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      // Use the showSnackBar function to display error messages
      showSnackBar(context, e.message.toString());
      res = false;
    }
    return res;
  }
}
