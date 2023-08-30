// driver repository to perform database operations
// CRUD operations

import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverRepository extends GetxController {
  static DriverRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

// store the driver data in the firestore
  createUser(UserModel user) async {
    await _db
        .collection('drivers')
        .doc(user.uid)  // store the user id as the document id
        .set(user.toJson())
        // .add(user.toJson())
        // .whenComplete(
        //   () => Get.snackbar(
        //     "Success",
        //     "Your account has been created successfully",
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.green.withOpacity(0.1),
        //     colorText: Colors.green,
        //   ),
        // )
        .catchError((error, stackTrace) {
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          Get.snackbar(
            "Error",
            "The password provided is too weak.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red,
          );
        } else if (error.code == 'email-already-in-use') {
          Get.snackbar(
            "Error",
            "The account already exists for that email.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red,
          );
        }
      }

            // SignUpWithEmailAndPasswordFailure();
          
      // Get.snackbar(
      //   "Error",
      //   "Something went wrong, please try again later",
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red.withOpacity(0.1),
      //   colorText: Colors.red,
      // );
    });
  }

  // fetch the driver data from the firestore
  Future<UserModel> getDriverData() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final snapshot =
        await _db.collection("drivers").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // get(fetch) the driver data from the firestore
  Future<UserModel> getDriverDetails(String email) async {
    final snapshot =
        await _db.collection("drivers").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allDriver() async {
    final snapshot = await _db.collection("drivers").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
}
