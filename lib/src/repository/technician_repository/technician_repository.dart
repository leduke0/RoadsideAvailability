// driver repository to perform database operations
// CRUD operations

import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/features/authentication/models/technician_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicianRepository extends GetxController {
  static TechnicianRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

// store the driver data in the firestore
  createUser(TechModel user) async {
    await _db
        .collection('technicians')
        .doc(user.uid)
        .set(user.toJson())
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
      Get.snackbar(
        "Error",
        "Something went wrong, please try again later",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    });
  }

  // fetch the driver data from the firestore
  Future<TechModel> getTechnicianData() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final snapshot =
        await _db.collection("technicians").where("Email", isEqualTo: email).get();
    final TechModel userData = snapshot.docs.map((e) => TechModel.fromSnapshot(e)).single;
    return userData;
  }

  // get(fetch) the driver data from the firestore
  Future<TechModel> getTechnicianDetails(String technicianId) async {
    final snapshot =
        await _db.collection("technicians").doc(technicianId).get();
    final TechModel userData = TechModel.fromSnapshot(snapshot);
    return userData;
  }

  Future<List<TechModel>> allTechnician() async {
    final snapshot = await _db.collection("technicians").get();
    final userData =
        snapshot.docs.map((e) => TechModel.fromSnapshot(e)).toList();
    return userData;
  }
 }
