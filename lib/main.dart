import 'package:flutter/material.dart';
import 'package:group5finalproject/Pages/landing_page.dart';
import 'Pages/register_screen.dart'; //wala na ni cya

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: LandingPage(),
        ),
      ),
    );
  }
}
