import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onLogin;

  const LoginButton({
    Key? key,
    required this.onLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onLogin,
      child: const Text('Login'),
    );
  }
}
