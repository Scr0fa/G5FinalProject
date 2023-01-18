import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Services/auth_services.dart';
import '../Services/globals.dart';
import '../rounded_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: 900,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login-bg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop)
                    )
                ),
                child: Stack(
                    children: [
                      Positioned(
                          left: 20,
                          top: 200,
                          child: Container(
                              width: 370,
                              height: 600,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0x66ffffff),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 260,
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your email',
                                      ),
                                      onChanged: (value) {
                                        _email = value;
                                        },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your password',
                                      ),
                                      onChanged: (value) {
                                        _password = value;
                                        },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    RoundedButton(
                                      btnText: 'Login',
                                      onButtonPressed: () => loginPressed(),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    RoundedButton(
                                      btnText: 'Register',
                                      onButtonPressed: () => registerRoute(),
                                    )
                                  ],
                                ),
                              )
                          ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 180, 0, 0),
                        width: double.infinity,
                        child: SizedBox(
                          width: 240,
                          height: 300,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ]
                )
            )
        )
    );
  }
}
