import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'myViews/bottom_navbar.dart';
import 'package:appointment_app/screens/addnew_appt_screen.dart';
import 'package:appointment_app/screens/home_screen.dart';
import 'package:appointment_app/screens/login_screen.dart';
import 'package:appointment_app/screens/set_appt_screen.dart';
import 'package:appointment_app/screens/wrapped_appt_screen.dart';
import 'package:appointment_app/screens/register_screen.dart';
import 'package:appointment_app/styles/app_styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAr2tkIdrWN_K_TnpjenjMT8PwuH_nQpJ4",
      appId: "1:243828159731:android:5a09b21c49a1a5c61c3386",
      messagingSenderId: "243828159731",
      projectId: "appointment-app-data",
    ),
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
      ),
      home: const InitialScreen(),
      routes: {
        "bottom_navbar": (context) => const MyBottomNavBar(),
        "home_screen": (context) => const HomeScreen(),
        "wrapped_appt_screen": (context) => const WrappedApptScreen(),
        "set_appt_screen": (context) => const SetApptScreen(),
        "addnew_appt_screen": (context) => const AddnewApptScreen(),
        "login_screen": (context) => const LoginScreen(),
        "register_screen": (context) => const RegisterScreen(),
      },
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  InitialScreenState createState() => InitialScreenState();
}

class InitialScreenState extends State<InitialScreen> {
  bool _isUserLoggedIn = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    setState(() {
      _loading = true;
    });

    // Check if a Firebase user is logged in
    User? user = FirebaseAuth.instance.currentUser;

    // Get the shared preferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Update login status in SharedPreferences
    if (user != null) {
      await prefs.setBool('isUserLoggedIn', true);
    } else {
      await prefs.setBool('isUserLoggedIn', false);
    }

    // Fetch the login status from SharedPreferences
    bool? isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;

    setState(() {
      _isUserLoggedIn = isUserLoggedIn;
      _loading = false;
    });

    // Navigate based on login status
    if (!_isUserLoggedIn) {
      Navigator.pushReplacementNamed(context, "login_screen");
    } else {
      Navigator.pushReplacementNamed(context, "bottom_navbar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            color: AppStyles.bgColor, child: const CircularProgressIndicator())
        : Container(color: AppStyles.bgColor); // Return an empty Container
  }
}
