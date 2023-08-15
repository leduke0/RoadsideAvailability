import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/controllers/signup_controller.dart';
import 'package:chop_ya/src/features/authentication/screens/forgot_password/forget_passsword_otp/otp_screen.dart';
import 'package:chop_ya/src/features/authentication/screens/verification/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // calling the controllers
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 5),
      child: Form(
        // using the form key for the forms to be submitted
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            controller: controller.fullName,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                labelText: tFullName,
                hintText: tFullName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          TextFormField(
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          TextFormField(
            controller: controller.phoneNo,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.call),
                labelText: tPhoneNo,
                hintText: tPhoneNo,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          TextFormField(
            controller: controller.password,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: const Icon(Icons.remove_red_eye_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: tFormHeight - 10,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // SignUpController.instance.registerUser(
                      //     controller.email.text.trim(),
                      //     controller.password.text.trim());
                      SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      Get.to(() => const OTPScreen());
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: tDefaultSize - 16)),
                  child: Text(tSignup.toUpperCase())))
        ]),
      ),
    );
  }
}
