import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: isDesktop ? 16 : (isTablet ? 15 : 14)),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: isDesktop ? 16 : (isTablet ? 15 : 14)),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey[600],
          size: isDesktop ? 24 : (isTablet ? 22 : 20),
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 20 : (isTablet ? 18 : 16),
          vertical: isDesktop ? 20 : (isTablet ? 18 : 16),
        ),
      ),
      validator: validator,
    );
  }
}
