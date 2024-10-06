import 'package:flutter/material.dart';

class SignInBar extends StatelessWidget {
  const SignInBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'Sign in',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}
