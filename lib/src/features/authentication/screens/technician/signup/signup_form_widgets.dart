import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/core/controllers/signUpTech_controller.dart';
import 'package:chop_ya/src/features/authentication/models/driver_model.dart';
import 'package:chop_ya/src/features/authentication/models/technician_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {

  final _db = FirebaseFirestore.instance;
  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    // calling the controllers
    final controller = Get.put(SignUpTechController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 5),
      child: Form(
        // using the form key for the forms to be submitted
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your full name';
              } else if (value.length < 3) {
                return 'Please enter a valid name';
              } else if (value.length > 20) {
                return 'Please enter a valid name';
              } 
              return null;
            },
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
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
          // IntlPhoneField(
          //   controller: controller.phoneNo,
          //   keyboardType: TextInputType.phone,
          //   decoration: InputDecoration(
          //     labelText: 'Phone Number',
          //     hintText: 'Enter phone number',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          //   initialCountryCode: 'CM',
          //   onChanged: (phone) {
          //     print(phone.completeNumber);
          //   },
          // ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your phone number';
              } else if (value.length < 13) {
                return 'Please enter a valid phone number';
              } else if (value.length > 13) {
                return 'Please enter a valid phone number';
              } else if (value.contains(RegExp(r'[a-zA-Z]'))) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            controller: controller.phoneNo,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                labelText: tPhoneNo,
                hintText: '+237 6XX XXX XXX',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your location';
              }
              return null;
            },
            controller: controller.location,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_pin),
                labelText: tLocation,
                hintText: tLocation,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'password must be atleast 6 characters long';
              }
              return null;
            },
            obscureText: _isObscured,
            controller: controller.password,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
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
                      // SignUpController.instance.phoneAuthentication(
                      //     controller.phoneNo.text.trim());
                      // SignUpController.instance.registerUser(
                      //   controller.email.text.trim(),
                      //   controller.password.text.trim());
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));

                      // get user and pass it to controller

                      final user = TechModel(
                       
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        fullName: controller.fullName.text.trim(),
                        phoneNo: controller.phoneNo.text.trim(),
                        location: controller.location.text.trim(),
                      );

                      SignUpTechController.instance.createUser(user);
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
