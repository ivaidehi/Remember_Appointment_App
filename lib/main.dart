import 'package:appointment_app/screens/home_screen.dart';
import 'package:appointment_app/screens/login_screen.dart';
import 'package:appointment_app/screens/set_appt_screen.dart';
import 'package:appointment_app/screens/wrapped_appt_screen.dart';
import 'package:appointment_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'myViews/bottom_navbar.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAr2tkIdrWN_K_TnpjenjMT8PwuH_nQpJ4",
        appId: "1:243828159731:android:5a09b21c49a1a5c61c3386",
        messagingSenderId: "243828159731",
        projectId: "appointment-app-data")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        // scaffoldBackgroundColor: Colors.blue[50],
      ),

      home: const RegisterScreen(),
      // home: const MyBottomNavBar(),
      routes: {
        "bottom_navbar": (context) => const MyBottomNavBar(),
        "home_screen": (context) => const HomeScreen(),
        "wrapped_appt_screen": (context) => const WrappedApptScreen(),
        "set_appt_screen": (context) => const SetApptScreen(),
        "login_screen": (context) => const LoginScreen(),
        "register_screen": (context) => const RegisterScreen(),
      },
    );
  }
}
