import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_passsword_otp/otp_screen.dart';
import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:chop_ya/src/repository/driver_repository/driver_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from text fields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(DriverRepository());

  // call this function from design and it will validate all fields
  void registerUser(
    String email,
    String password,
  ) {
    // calling the firebase logic or performing additional validation here
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  // get phoneNo from user and pass it to Auth Repository for firebase Authentication

  Future<void> createUser(UserModel user) async {
    // calling the firebase logic or performing additional validation here
    await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(user.email, user.password);

        // assign uid to the current user
        UserModel userWithUid = user.copyWith(uid: FirebaseAuth.instance.currentUser!.uid);
        print(userWithUid.toString());
        // await userRepo
        // .createUser(user.copyWith(uid: FirebaseAuth.instance.currentUser!.uid));
      await userRepo.createUser(userWithUid);
      // print the updated user data
      

    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String phoneNo) {
    // calling the firebase logic or performing additional validation here
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
