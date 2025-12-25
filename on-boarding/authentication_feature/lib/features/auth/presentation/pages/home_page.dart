import 'package:authentication_feature/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_event.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_state.dart';
import 'package:authentication_feature/features/auth/presentation/pages/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    String displayText = 'Unknown';
    String userName = '';

    if (authState is Authenticated) {
      displayText = 'Logged in as: ${authState.user.email}';
      userName = authState.user.name;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $userName', style: TextStyle(fontSize: 30)),
            SizedBox(height: 25,),
            Text(displayText, style: const TextStyle(fontSize: 20)),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false, 
                );
              },
              child: Text('Log Out', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
