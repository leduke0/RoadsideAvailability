import 'package:flutter/material.dart';

class ForgotPasswordBtnWidget extends StatelessWidget {
  const ForgotPasswordBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    super.key,
  });

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
             Icon(
              btnIcon,
              size: 60,
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context)
                        .primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w300
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: Theme.of(context)
                        .primaryColor,
                    fontSize: 15,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
