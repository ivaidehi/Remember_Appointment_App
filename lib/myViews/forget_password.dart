import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../styles/app_styles.dart';
import '../myWidgets/input_field_widget.dart';
import '../myWidgets/line_widget.dart';
import '../myWidgets/sub_heading_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your email';
      });
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Password Reset Email Sent'),
          content: const Text('Check your email to reset your password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        backgroundColor: AppStyles.bgColor,
        // title: Text(
        //   'Reset Password',
        //   style: TextStyle(color: AppStyles.primary),
        // ),
        // centerTitle: true,
        // elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Reset Password',
              style:
                  AppStyles.headLineStyle1.copyWith(color: AppStyles.primary),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            // Subtitle
            Text(
              'Enter your registered email address. We will send you a password reset link.',
              style: AppStyles.headLineStyle3.copyWith(color: Colors.black54),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 40),
            // Email Input Field
            InputFieldWidget(
              defaultHintText: 'Enter your registered email',
              controller: emailController,
              requiredInput: 'Email',
              showWarning: errorMessage,
              suffixIcon: Icon(Icons.email, color: AppStyles.secondary),
            ),
            const SizedBox(height: 30),
            // Submit Button
            SizedBox(
              width: 150,
              // height: 45,
              child: ElevatedButton(
                onPressed: resetPassword,
                style: AppStyles.buttonStyle,
                child: Text(
                  'Submit',
                  style:
                      AppStyles.headLineStyle3_0.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Optional Line Widget
            const LineWidget(),
            const SizedBox(height: 20),
            // Footer or additional instructions
            const SubHeadingWidget(subHeading: 'Need help? Contact support'),
          ],
        ),
      ),
    );
  }
}
