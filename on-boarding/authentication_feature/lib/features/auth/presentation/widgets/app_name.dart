import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final VoidCallback onPressed;
  const AppName({
    super.key,
    required this.width,
    required this.height,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.41),
          border: Border.all(color: Color.fromRGBO(63, 81, 243, 1)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.35),
              offset: Offset(1, 3),
              blurRadius: 5.0,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
      
        child: Text(
          'ECOM',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size,
            fontFamily: 'Caveat Brush',
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 81, 243, 1),
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
