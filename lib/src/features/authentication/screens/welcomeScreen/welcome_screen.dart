import 'package:chop_ya/src/constants/image_strings.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/login/login_screen.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(tWelcomeScreenImage),
                height: height * 0.6,
              ),
              Column(
                children: const [
                   Text(
                    tWelcomeTitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    tWelcomeSubTitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        key: const Key('driver_button'),
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black),
                            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)
                          ),
                          child: Text(tDriver.toUpperCase()))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                        key: const Key('technician_button'),
                          onPressed: () {
                            Get.to(() => const LoginScreenTech());
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(),
                            padding: const EdgeInsets.symmetric(vertical: tButtonHeight)
                          ),
                          child: Text(tTechnician.toUpperCase()))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
