import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTxtFormField extends StatelessWidget {
  CustomTxtFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.controller,
    this.obsecureText = false,
    this.onChanged,
  });

  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  bool obsecureText;
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(color: Theme.of(context).colorScheme.secondary),
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      // autovalidateMode: AutovalidateMode.always,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      obscureText: obsecureText,
      onChanged: onChanged,
    );
  }
}
