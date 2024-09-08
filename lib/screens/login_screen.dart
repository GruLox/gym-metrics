import 'package:gym_metrics/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/widgets/email_field.dart';
import 'package:gym_metrics/widgets/login_button.dart';
import 'package:gym_metrics/widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();

  const LoginScreen({Key? key}) : super(key: key);
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final userState = Provider.of<UserState>(context, listen: false);
        await userState.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        Navigator.pushReplacementNamed(context, '/');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
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
              const Text(
                'Login',
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                EmailField(controller: _emailController),
                const SizedBox(height: 12.0),
                PasswordField(controller: _passwordController),
                const SizedBox(height: 20.0),
                LoginButton(onLogin: _login),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: const Text(
                    'Don\'t have an account?',
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
