import 'package:flutter/material.dart';
import 'package:group5finalproject/Pages/login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double size = MediaQuery.of(context).size.width / baseWidth;
    double sizes = size *1;

    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        height: 850*size,
        child: Stack(
          children: [
            Positioned(
              left: 0*size,
              top: 0*size,
              child: Container(
                width: 360*size,
                height: 800*size,
                decoration: const BoxDecoration (
                  color: Color(0xff19191c),
                  image: DecorationImage (
                    fit: BoxFit.cover,
                    image: AssetImage (
                      'assets/images/landing-bg.png',
                    ),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 800*size,
                    child: Container(
                      decoration: const BoxDecoration (
                        color: Color(0x66000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 27*size,
              top: 120*size,
              child: SizedBox(
                width: 206*size,
                height: 300*size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0*size, 0*size, 0*size, 25*size),
                      width: 142*size,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0*size, 0*size, 0*size, 30*size),
                            width: double.infinity,
                            child: Text(
                              'Welcome to',
                              textAlign: TextAlign.center,
                              style: TextStyle (
                                fontSize: 25*sizes,
                                fontWeight: FontWeight.w600,
                                height: 1*sizes/size,
                                letterSpacing: -0.4079999924*size,
                                color: const Color(0xff0075ff),
                              ),
                            ),
                          ),
                          Text(
                            '   MyDay',
                            style: TextStyle (
                              fontSize: 45*sizes,
                              fontWeight: FontWeight.w600,
                              height: 0.2*sizes/size,
                              letterSpacing: -0.4079999924*size,
                              color: const Color(0xff0075ff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints (
                        maxWidth: 300*size,
                      ),
                      child: Text(
                        'Wanna record your day? You\'ve chosen the right app.',
                        style: TextStyle (
                          fontSize: 13*sizes,
                          fontWeight: FontWeight.w400,
                          height: 1.5*sizes/size,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 250*size,
              top: 650*size,
              child: Align(
                child: SizedBox(
                  width: 82*size,
                  height: 82*size,
                  child: TextButton(
                    onPressed: () async{
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()
                          )
                      );
                    },
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Icon(Icons.arrow_circle_right_sharp,
                      size: 75*size,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
