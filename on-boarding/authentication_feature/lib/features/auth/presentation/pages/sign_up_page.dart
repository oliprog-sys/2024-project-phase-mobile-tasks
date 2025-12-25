import 'package:authentication_feature/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_event.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_state.dart';
import 'package:authentication_feature/features/auth/presentation/pages/log_in_page.dart';
import 'package:authentication_feature/features/auth/presentation/pages/splash_page.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/app_name.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/button.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/input_field.dart';
import 'package:authentication_feature/features/auth/presentation/widgets/navigate_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  bool isChecked = false;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passCtrl.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void validateAndShowErrors(BuildContext context) {
    final nameError = validateName(nameCtrl.text);
    final emailError = validateEmail(emailCtrl.text);
    final passwordError = validatePassword(passCtrl.text);
    final confirmPasswordError = validateConfirmPassword(
      confirmPasswordCtrl.text,
    );

    if (nameError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(nameError),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailError),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(passwordError),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(confirmPasswordError),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms & policy'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      SignUpRequested(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passCtrl.text,
      ),
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          });
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 10, 92, 216),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  AppName(
                    width: 78,
                    height: 30,
                    size: 23,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SplashPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Sign into your account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  Text(
                    'Name',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),

                  SizedBox(height: 12),

                  InputField(
                    type: TextInputType.text,
                    placeholder: 'ex: jon smith',
                    controller: nameCtrl,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Email',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),

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

                  InputField(
                    type: TextInputType.visiblePassword,
                    placeholder: '********',
                    isPassword: true,
                    controller: passCtrl,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Confirm Password',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),

                  InputField(
                    type: TextInputType.visiblePassword,
                    placeholder: '*********',
                    isPassword: true,
                    controller: confirmPasswordCtrl,
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                          debugPrint('Checkbox clicked: $value');
                        },
                      ),

                      Text('I understand the', style: TextStyle(fontSize: 14)),

                      NavigateLink(
                        text: ' terms & policy.',
                        onTap: () {
                          print('show terms and conditions');
                        },
                      ),
                    ],
                  ),

                  Button(
                    text: 'SIGN UP',
                    onPressed: () => validateAndShowErrors(context),
                  ),

                  SizedBox(height: 80),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      NavigateLink(
                        text: 'SIGN IN',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
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
