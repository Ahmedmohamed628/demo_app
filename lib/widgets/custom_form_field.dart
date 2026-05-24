import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    // required this.hintText,
    required this.labelText,
    // this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.isEmail = false,
    // this.isObscure = false,
    this.onSuffixIconTap,
  });

  // final String hintText;
  final String labelText;

  // final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;

  // final bool isObscure;
  final VoidCallback? onSuffixIconTap;

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $labelText';
        }
        if (isEmail && !isEmailValid(value)) {
          return 'Please enter a valid email address';
        }
        if (isPassword && value.length < 8) {
          return 'Password should be at least 8 characters';
        }
        return null;
      },

      // obscureText: isPassword ? isObscure : false,
      cursorColor: Colors.white,
      cursorHeight: 20,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.transparent,
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.white),
        // hintText: hintText,
        // hintStyle: TextStyle(color: Colors.white),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.white,
        errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
