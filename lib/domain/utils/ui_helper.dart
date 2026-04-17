import 'package:flutter/material.dart';

InputDecoration mInputFieldDecoration({
  required String hintText,
  required String labelText,
  bool isPassField = false,
  bool isPassVisible = false,
  VoidCallback? onTap,
}){
  return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      suffixIcon: isPassField ? IconButton(
        onPressed: onTap,
        icon: isPassVisible
            ? Icon(Icons.visibility_outlined)
            : Icon(Icons.visibility_off_outlined),
      ) : null,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2,
              color: Colors.pink.shade200
          ),
          borderRadius: BorderRadius.circular(11)
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
      )
  );
}