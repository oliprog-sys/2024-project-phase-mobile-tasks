import 'package:flutter/material.dart';
class NavigateLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const NavigateLink({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Text(
        text,
        style: TextStyle(
          color: Color.fromRGBO(63, 81, 243, 1),
          fontSize: 15,
          fontWeight: FontWeight.w500,

        ),
      ),

      
    );
    
  }
}