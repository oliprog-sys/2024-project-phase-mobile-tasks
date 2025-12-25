import 'package:authentication_feature/features/auth/presentation/pages/log_in_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_bg.png', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(63, 81, 243, 0.6),
                  Color.fromRGBO(63, 81, 243, 1),
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  },
                  child: Container(
                    width: 264,
                    height: 121,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(31),
                    ),
                    child: Text(
                      'ECOM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 70,                        
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(63, 81, 243, 1),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Ecommerce App',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
