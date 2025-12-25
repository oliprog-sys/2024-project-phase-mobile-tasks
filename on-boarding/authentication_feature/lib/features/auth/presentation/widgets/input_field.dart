import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String placeholder;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController? controller;
  const InputField({super.key, required this.type, required this.placeholder, this.isPassword = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 42,

      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),        
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        decoration:  InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            // fontSize: 14
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10
          )
        ),
      ),
    );
  }
}
