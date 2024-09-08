import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/states/user_state.dart';
import 'package:gym_metrics/widgets/email_field.dart';
import 'package:gym_metrics/widgets/password_field.dart';
import 'package:gym_metrics/widgets/registration_button.dart';
import 'package:gym_metrics/widgets/username_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

  const RegisterScreen({Key? key}) : super(key: key);
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final userState = Provider.of<UserState>(context, listen: false);
        await userState.createUserWithEmailAndPassword(
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
        );
        if (userState.user != null) {
          Navigator.pushReplacementNamed(context, '/');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                'The email address is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'operation-not-allowed':
            errorMessage = 'Email/password accounts are not enabled.';
            break;
          case 'weak-password':
            errorMessage = 'The password is too weak.';
            break;
          default:
            errorMessage = 'An unknown error occurred. Please try again.';
        }
        _showError(errorMessage);
      } catch (e) {
        _showError(e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymMetrics'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Register',
                  style: TextStyle(fontSize: 30.0),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                UsernameField(controller: _usernameController),
                const SizedBox(height: 12.0),
                EmailField(controller: _emailController),
                const SizedBox(height: 12.0),
                PasswordField(controller: _passwordController),
                const SizedBox(height: 20.0),
                RegistrationButton(
                  onRegister: _register,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
