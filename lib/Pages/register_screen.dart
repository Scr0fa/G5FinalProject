import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group5finalproject/Services/auth_services.dart';
import 'package:group5finalproject/utility/rounded_button.dart';
import '../Services/globals.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';

  createAccountPressed() async {
    bool emailValid = RegExp(
        r"^[a-zA-Z\d.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      http.Response response =
      await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
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
                        top: 160,
                        child: Container(
                          width: 370,
                          height: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0x66ffffff),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 200,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Name',
                                  ),
                                  onChanged: (value) {
                                    _name = value;
                                    },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Email',
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
                                    hintText: 'Password',
                                  ),
                                  onChanged: (value) {
                                    _password = value;
                                    },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                RoundedButton(
                                  buttonText: 'Create Account',
                                  onButtonPressed: () => createAccountPressed(),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                    },
                                  child: const Text(
                                    'already have an account?',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 180, 0, 0),
                      width: double.infinity,
                      child: SizedBox(
                        width: 240,
                        height: 200,
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
