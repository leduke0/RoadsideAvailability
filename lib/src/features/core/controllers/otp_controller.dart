import 'package:chop_ya/src/common_widgets/navigationBar.dart';
import 'package:chop_ya/src/features/core/screens/driver/dashboard/dashboard.dart';
import 'package:chop_ya/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    // isVerified ? Get.to(const Dashboard()) : Get.back();
    if (isVerified) {
      Get.to(() =>  NavBar());
      Get.snackbar('Success', 'OTP verified successfully');
    } else {
      Get.back();
    }
    
    
  }
}