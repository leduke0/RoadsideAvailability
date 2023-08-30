import 'package:chop_ya/src/common_widgets/form/form_header_widget.dart';
import 'package:chop_ya/src/constants/image_strings.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_passsword_otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const SizedBox(
                  height: tDefaultSize,
                ),
                const FormHeaderWidget(
                    // size: Size(1, 1000),
                    image: tForgetPasswordImage,
                    subTitle: tForgetPasswordSubTitle,
                    title: tForgetPassword,
                    textAlign: TextAlign.center),
                // section 2
                const SizedBox(
                  height: tFormHeight,
                ),
                Form(child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(tEmail),
                        hintText: tEmail,
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const OTPScreen());
                          },
                          style: ElevatedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(vertical: 18.0)
                          ),
                          child: Text(tNext.toUpperCase())),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
