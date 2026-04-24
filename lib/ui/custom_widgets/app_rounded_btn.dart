import 'package:flutter/material.dart';

class AppRoundedBtn extends StatelessWidget {
  double mWidth, mHeight;
  String title;
  Color? bgColor, fgColor;
  void Function() onTap;
  bool isLoading;

  AppRoundedBtn({
    this.mWidth = double.infinity,
    this.mHeight = 50,
    required this.title,
    this.bgColor,
    this.fgColor,
    required this.onTap,
    this.isLoading = false
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
        child: isLoading ? Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                width: 11,
              ),
              Text(title)
            ],
          ),
        ) : Text(title),
      ),
    );
  }
}
