import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 5),
      child: Form(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.person_outline_outlined),
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
                      onPressed: () {},
                      child: Text(tSignup.toUpperCase()),
                      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: tDefaultSize - 16))
                      ))
            ]),
      ),
    );
  }
}