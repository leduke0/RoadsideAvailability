import 'package:chop_ya/src/common_widgets/form/form_header_widget.dart';
import 'package:chop_ya/src/constants/image_strings.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/login/login_footer_widget.dart';
import 'package:chop_ya/src/features/authentication/screens/technician/login/login_form_widget.dart';
import 'package:flutter/material.dart';

class LoginScreenTech extends StatelessWidget {
  const LoginScreenTech({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    FormHeaderWidget(
                        // size: size,
                        image: tLoginSignup,
                        subTitle: tLoginTit,
                        title: tLoginTitle),
                    // section 2
                    LoginForm(),
                    LoginFooter()
                  ],
                ))),
      ),
    );
  }
}
