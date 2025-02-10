import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/login_signup.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/color.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Add this
        primaryColor: primary,
        textTheme: GoogleFonts.gabaritoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LoginSignup(),
      routes: {
        LoginSignup.routeName: (context) => const LoginSignup(),
      },
    );
  }
}