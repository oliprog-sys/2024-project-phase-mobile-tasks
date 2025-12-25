// import 'package:authentication_feature/features/auth/presentation/pages/log_in_page.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_feature/injection_container.dart';
// import 'package:authentication_feature/features/auth/presentation/pages/sign_up_page.dart';
import 'package:authentication_feature/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
 Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        // home: LoginPage(),
        // home: SignUpPage(),
      ),
    );
  }
}