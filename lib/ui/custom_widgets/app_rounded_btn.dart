import 'package:flutter/material.dart';

class AppRoundedBtn extends StatelessWidget {
  double mWidth, mHeight;
  String title;
  Color? bgColor, fgColor;
  void Function() onTap;

  AppRoundedBtn({
    this.mWidth = double.infinity,
    this.mHeight = 50,
    required this.title,
    this.bgColor,
    this.fgColor,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
      height: mHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.pink.shade200,
          foregroundColor: fgColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }
}
