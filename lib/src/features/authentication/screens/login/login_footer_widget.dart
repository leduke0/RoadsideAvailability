import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(height: tFormHeight - 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            icon: Image(
              image: AssetImage('assets/logo/google_logo.png'),
              width: 30,
            ),
            onPressed: () {},
            label: const Text(tSignInWithGoogle),
          ),
        ),
        const SizedBox(height: tFormHeight - 10),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: const Text.rich(TextSpan(
                text: tDontHaveAnAccount,
                children: [
                  TextSpan(text: tSignup, style: TextStyle(color: Colors.green))
                ])))
      ],
    );
  }
}
