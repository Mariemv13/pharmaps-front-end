import 'package:flutter/material.dart';

class LogoSpace extends StatelessWidget {
  const LogoSpace({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/pharmaps.png",
            width: 115,
          ),
          child ?? const SizedBox()
        ],
        )
    );
  }
}