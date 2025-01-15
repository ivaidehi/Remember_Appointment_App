import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../myWidgets/input_field_widget.dart';
import '../myWidgets/line_widget.dart';
import '../styles/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var useremailcontroller = TextEditingController();
  var passwordController = TextEditingController();

  String useremail = "", password = "";
  final _formkey = GlobalKey<FormState>();

  var userNotFound = 'user-not-found';
  var wrongPassword = 'wrong-password';

  String? _emailWarning, _passwordWarning;

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: useremail,
        password: password,
      );

      // Successful login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successfully.')),
      );
      Navigator.pushNamed(context, 'bottom_navbar');
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Update showWarning based on the error code
        if (e.code != 'user-not-found') {
          // Default error handling
          _passwordWarning = null;
          _emailWarning = 'Invalid Email, please try again';
        }

        if (e.code != 'wrong-password') {
          // Default error handling
          _emailWarning = null;
          _passwordWarning = 'Invalid Password, please try again';
        }

        if (e.code != 'user-not-found' && e.code != 'wrong-password') {
          // Default error handling
          _emailWarning = 'Invalid Email, please try again';
          _passwordWarning = 'Invalid Password, please try again';
        }
      });

      // Re-validate the form to show the error messages
      _formkey.currentState?.validate();
    }
  }



  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(35),
            margin: const EdgeInsets.symmetric(vertical: 150),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    "Welcome Back !",
                    style: AppStyles.headLineStyle2.copyWith(
                        color: AppStyles.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputFieldWidget(
                    defaultHintText: 'Enter Email ID',
                    controller: useremailcontroller,
                    showWarning: _emailWarning,
                    requiredInput: 'Email id',
                    hideText: false,
                    suffixIcon: Icon(
                      Icons.email_rounded,
                      color: AppStyles.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputFieldWidget(
                    defaultHintText: 'Enter Password',
                    controller: passwordController,
                    showWarning: _passwordWarning,
                    requiredInput: 'Password',
                    hideText:
                        !_visibility, // [Not _isPasswordVisible=false]--> (i.e password is visible / (TRUE) )
                    // Now the at last bool
                    suffixIcon: IconButton(
                      icon: Icon(
                        color: AppStyles.secondary,
                        _visibility ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'forget_password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppStyles.headLineStyle3.copyWith(color: AppStyles.secondary)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    // height: 45,
                    child: ElevatedButton(
                      style: AppStyles.buttonStyle,
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            useremail = useremailcontroller.text;
                            password = passwordController.text;
                          });
                          login();
                        } else {
                          setState(() {}); // Add this line
                        }
                      },
                      child: Text(
                        'Login',
                        style: AppStyles.headLineStyle3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      const LineWidget(),
                      Center(
                        child: Container(
                          color: AppStyles.bgColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2), // Adjust padding as needed
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: AppStyles
                                  .secondary, // Change text color for better visibility
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'Sign in with',
                        style: TextStyle(
                          color: AppStyles.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              width: 35,
                              height: 35,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/fb.png',
                              width: 35,
                              height: 35,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/apple_logo.png',
                              width: 40,
                              height: 40,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // Already have an account-->  login
                      Container(
                        color: AppStyles.bgColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2), // Adjust padding as needed
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'register_screen');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an Account?',
                                style: TextStyle(
                                  color: AppStyles
                                      .secondary, // Change text color for better visibility
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Register',
                                style: AppStyles.headLineStyle4.copyWith(
                                  color: AppStyles.primary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline, // Adds underline to the text
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

container({required Alignment alignment, required GestureDetector child}) {}
