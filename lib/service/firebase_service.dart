import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/service/models/user_mdel.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
//sign up by firebase
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        MyUser myUser = MyUser(id: user.uid, email: email, password: password);

        // save data to Firestore firbase
        await firestore.collection('users').doc(user.uid).set(myUser.toMap());
      }
    } catch (e) {
      debugPrint("failed: $e");
    }
  }

// save User data To Firestore (name , age ,hobby)
  Future<void> saveUserData(Map<String, dynamic>? userData) async {
    User? user = auth.currentUser;

    if (user != null) {
      await firestore.collection("users").doc(user.uid).set(userData!);
    } else {
      debugPrint("No user found");
    }
  }

// get User data frim Firestore (name , age ,hobby)
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint("No user found");
        return null;
      }

      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        debugPrint("User: ${doc.data()}");
        return doc.data();
      } else {
        debugPrint("No user found");
        return null;
      }
    } catch (e) {
      debugPrint("failed: $e");
      return null;
    }
  }
}
