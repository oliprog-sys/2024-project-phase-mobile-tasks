import 'package:authentication_feature/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_event.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_state.dart';
import 'package:authentication_feature/features/auth/presentation/pages/home_page.dart';
import 'package:authentication_feature/features/auth/presentation/pages/sign_up_page.dart';
import 'package:authentication_feature/features/auth/presentation/pages/splash_page.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/app_name.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/button.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/input_field.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/navigate_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        } else if (state is Unauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
            (route) => false,
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text('Sign In', style: TextStyle(fontSize: 25)),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Center(
                    child: AppName(
                      width: 148,
                      height: 50,
                      size: 38,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SplashPage()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 70),
                  Center(
                    child: Text(
                      'Sign into your account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.006,
                      ),
                    ),
                  ),

                  SizedBox(height: 35),

                  Text(
                    'Email',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 12),
                  InputField(
                    type: TextInputType.emailAddress,
                    placeholder: 'ex: jon.smith@email.com',
                    controller: emailCtrl,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 12),
                  InputField(
                    type: TextInputType.visiblePassword,
                    placeholder: '*********',
                    isPassword: true,
                    controller: passwordCtrl,
                  ),

                  SizedBox(height: 35),

                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Button(
                          text: 'SIGN IN',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              SignInRequested(
                                email: emailCtrl.text.trim(),
                                password: passwordCtrl.text.trim(),
                              ),
                            );
                          },
                        ),

                  SizedBox(height: 150),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      NavigateLink(
                        text: 'SIGN UP',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignUpPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
