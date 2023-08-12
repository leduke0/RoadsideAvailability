import 'package:chop_ya/src/common_widgets/navigationBar.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/forgot_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:chop_ya/src/features/authentication/screens/forgot_password/forget_password_options/forget_password_modal_bottom_sheet.dart';
import 'package:chop_ya/src/features/core/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(height: tFormHeight - 10),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye_sharp),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(height: tFormHeight - 10),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ForgetPasswordScreen.buildShowModalBottomSheet(context);
                  },
                  child: const Text(
                    tForgetPassword,
                    style: TextStyle(color: Colors.green),
                  ))),
          const SizedBox(height: tFormHeight - 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavBar()));

                  // Get.to(() => const Dashboard());
                },
                child: Text(tLogin.toUpperCase()),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: tDefaultSize - 17))),
          ),
        ],
      ),
    ));
  }
}
