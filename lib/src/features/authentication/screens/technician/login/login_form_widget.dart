import 'package:chop_ya/src/common_widgets/form/techNavbar.dart';
import 'package:chop_ya/src/common_widgets/navigationBar.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/forgot_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/forgot_password/forget_password_options/forget_password_modal_bottom_sheet.dart';
import 'package:chop_ya/src/features/core/screens/technician/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _firebase = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _form = GlobalKey<FormState>();

  var _enteredEmail = "";
  var _enteredPassword = "";
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      _form.currentState!.save();
      // signup
      try {
        setState(() {
          _isAuthenticating = true;
        });
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        if (userCredentials.user != null) {
          Get.offAll(() =>  TechNavBar());
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //show message erroe
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ));
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  var _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                        _enteredEmail = value!;
                      },
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
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'password must be atleast 6 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                        _enteredPassword = value!;
                      },
                obscureText: _isObscured,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: tPassword,
                    hintText: tPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
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
              if (_isAuthenticating) const CircularProgressIndicator(),
                  if (!_isAuthenticating)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _submit,
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
