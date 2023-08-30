// import 'package:flutter/material.dart';

// class ForgetPasswordScreen {
//   Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.4,
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             const Text('Forgot Password'),
//             const SizedBox(height: 10),
//             const Text('Please enter your email address. You will receive a link to create a new password via email.'),
//             const SizedBox(height: 10),
//             TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('Send'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_password_phone/forgot_password_phone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_password_mail/forgot_password_mail.dart';
import 'package:chop_ya/src/features/authentication/screens/driver/forgot_password/forget_password_options/forget_password_btn_widget.dart';

class ForgetPasswordScreen {
  // using static you can easily access this method/function
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) => SingleChildScrollView(
          child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tForgetPasswordTitle,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(tForgetPasswordSubTitle,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          )),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ForgotPasswordBtnWidget(
                        btnIcon: Icons.mail_outline_outlined,
                        title: tEmail,
                        subTitle: tResetViaEMail,
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const ForgetPasswordMailScreen()));
                          Get.to(() => const ForgetPasswordMailScreen());
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ForgotPasswordBtnWidget(
                        btnIcon: Icons.mobile_friendly_rounded,
                        title: tPhoneNo,
                        subTitle: tResetViaPhone,
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(() => const ForgetPasswordPhoneScreen());
                        },
                      ),
                    ]),
              ),
        ));
  }
}
