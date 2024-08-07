import 'package:flutter/material.dart';
import 'package:pharmaps/utils/constants.dart';

class Illustration extends StatelessWidget {
  const Illustration(
      {super.key,
      this.child,
      this.image,
      this.title,
      this.subtitle1,
      this.subtitle2});
  final Widget? child;
  final String? image;
  final String? title;
  final String? subtitle1;
  final String? subtitle2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/Locationsearch-amico.png",
          width: 250,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          title!,
          style: regulerTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(
              subtitle1!,
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtitle2!,
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            const SizedBox(
              height: 40,
            ),
            child ?? const SizedBox(),
          ],
        ),
      ],
    );
  }
}
