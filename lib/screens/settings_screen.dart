import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin.copyWith(bottom: 50.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Future.delayed(Duration.zero, () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                });
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(200.0, 100.0)
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
