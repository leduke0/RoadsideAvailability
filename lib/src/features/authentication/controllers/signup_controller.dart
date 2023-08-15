import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from text fields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();


  // call this function from design and it will validate all fields
  void registerUser(
    String email,
    String password,
  ) {
    // calling the firebase logic or performing additional validation here
   String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }

  // get phoneNo from user and pass it to Auth Repository for firebase Authentication
  void phoneAuthentication(String phoneNo) {
    // calling the firebase logic or performing additional validation here
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}

