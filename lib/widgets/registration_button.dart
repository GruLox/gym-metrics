import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  final Function() onRegister;

  const RegistrationButton({
    Key? key,
    required this.onRegister

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onRegister,
      child: const Text('Register'),
    );
  }
}
