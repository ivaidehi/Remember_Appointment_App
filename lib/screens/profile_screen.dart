import 'package:appointment_app/styles/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(35),
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: GestureDetector(
          onTap: () async {
            try {
              // Sign out from Firebase
              await FirebaseAuth.instance.signOut();

              // Optionally, clear SharedPreferences or any other stored state
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('isUserLoggedIn');

              // Navigate to login screen after logout
              Navigator.of(context, rootNavigator: true).pushReplacementNamed("login_screen");

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout Successfully')),
              );

            } catch (e) {
              // Handle logout error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout failed: $e')),
              );
            }
          },
          child: Text(
            'Log Out',
            style: AppStyles.headLineStyle2_0.copyWith(
                color: AppStyles.primary,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
