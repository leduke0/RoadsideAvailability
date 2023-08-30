import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/core/screens/driver/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                Text(
                  tOtpTitle,
                  style: GoogleFonts.montserrat(
                      fontSize: 80, fontWeight: FontWeight.bold),
                ),
                Text(
                  tOtpSubTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(" $tOtpMessage nkengla@gmail.com",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  enabledBorderColor: Colors.black.withOpacity(0.1),
                  focusedBorderColor: Colors.black,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const Dashboard());
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18.0)),
                      child: Text(tNext.toUpperCase())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
