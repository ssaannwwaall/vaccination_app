import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_app/HomeScreen.dart';
import 'package:vaccination_app/LoginScreen.dart';
import 'package:vaccination_app/NewBirthChildScreen.dart';
import 'package:vaccination_app/NewRegisterationScreen.dart';
import 'package:vaccination_app/defaulterScreen.dart';
import 'SplashScreen.dart';
import 'UpcomingScreen.dart';
import 'VaccineToRegisKids.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Vaccination',
      home: SafeArea(
        child: Scaffold(
          body: SplashScreen(),
        ),
      ),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        NewBirthChildScreen.routeName: (ctx) => NewBirthChildScreen(),
        NewBirthChildScreen.routeName: (ctx) => NewBirthChildScreen(),
        NewRegisterationScreen.routeName: (ctx) => NewRegisterationScreen(),
        UpcomingScreen.routeName: (ctx) => UpcomingScreen(),
        DefaulterScreen.routeName: (ctx) => DefaulterScreen(),
        VaccineToRegisKids.routeName: (ctx) => VaccineToRegisKids(),
      },
    );
  }
}
