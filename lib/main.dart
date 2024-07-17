import 'package:appointment_app/screens/home_screen.dart';
import 'package:appointment_app/screens/set_appt_screen.dart';
import 'package:appointment_app/screens/wrapped_appt_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'myViews/demo.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
      home: const MyBottomNavBar(),
      routes: {
        "home_screen": (context) => const HomeScreen(),
        "wrapped_appt_screen": (context) => const WrappedApptScreen(),
        "set_appt_screen": (context) => const SetApptScreen(),
      },
    );
  }
}
