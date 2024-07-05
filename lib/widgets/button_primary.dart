import 'package:flutter/material.dart';
import 'package:pharmaps/utils/constants.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({super.key, this.text, this.onPressed});
  final String? text;
  final VoidCallback? onPressed; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
        child: Text(text!),
      ),
    );
  }
}