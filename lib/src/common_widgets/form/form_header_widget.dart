import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    // required this.size,
    required this.image,
    required this.subTitle,
    required this.title,
    this.imageHeight = 0.2,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  // variable declared in constructor
  final String image, title, subTitle;
  // final Size size;
  final double imageHeight;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: crossAxisAlignment, children: [
      // section 1
      // Image.asset(image, height: size.height * 0.2),
      Image(image: AssetImage(image), height: size.height * imageHeight),
      Text(title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30,
          )),
      Text(
        subTitle,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    ]);
  }
}
