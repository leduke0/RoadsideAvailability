import 'package:chop_ya/src/common_widgets/form/form_header_widget.dart';
import 'package:chop_ya/src/constants/image_strings.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/login/login_screen.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/signup/signup_form_widgets.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              const FormHeaderWidget(
                  // size: MediaQuery.of(context).size,
                  image: tLoginSignup,
                  subTitle: tTechLoginSubTitle,
                  title: tSignUpTitle),
              const SignUpFormWidget(),
              Column(
                children: [
                  const Text('OR'),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton.icon(onPressed: () {}, 
                    icon: const Image(image: AssetImage(tGoogleLogoImage), width: 30,), 
                    label: const Text(tSignInWithGoogle)),
                  ),
                  TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreenTech()),
              );
            },
            child: const Text.rich(TextSpan(
                text: tAlreadyHaveAnAccount,
                children: [
                  TextSpan(text: tLogin, style: TextStyle(color: Colors.green))
                ])))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}


