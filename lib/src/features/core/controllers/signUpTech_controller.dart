import 'package:chop_ya/src/features/authentication/models/technician_model.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_passsword_otp/otp_screen.dart';
import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:chop_ya/src/repository/technician_repository/technician_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpTechController extends GetxController {
  static SignUpTechController get instance => Get.find();

  // TextField Controllers to get data from text fields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final location = TextEditingController();

  final techRepo = Get.put(TechnicianRepository());

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

  Future<void> createUser(TechModel user) async {
    // calling the firebase logic or performing additional validation here
    await techRepo.createUser(user);
    await AuthenticationRepository.instance.createUserWithEmailAndPassword(user.email, user.password);
    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String phoneNo) {
    // calling the firebase logic or performing additional validation here
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
