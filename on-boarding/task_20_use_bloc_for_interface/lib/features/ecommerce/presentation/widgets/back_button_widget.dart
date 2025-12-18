import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: 24,
      child: FloatingActionButton(
        onPressed: () => {
          Navigator.pop(context),
        },
        elevation: 1,
        mini: true,
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Color.fromARGB(255, 10, 92, 216),
        ),
      ),
    );
  }
}
