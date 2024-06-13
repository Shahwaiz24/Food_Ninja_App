import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/Screens/initial_page/first_page.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isLoggedIn = prefs.getBool('isLoggedIn');

  return isLoggedIn ?? false;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> mainAsync() async {
    // Call checkUserLoggedIn() to get the login status
    bool isLoggedIn = await checkUserLoggedIn();

    // Now you can use the isLoggedIn variable
    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstPage()));
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      mainAsync();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Splash_Pattern.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.45),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Splash_Gradient.jpg'),
                  opacity: 0.9,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/images/Logo.jpg'),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Center(
                child: Text(
                  'Food Ninja',
                  style: TextStyle(
                    color: linearGreen,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.1,
                    fontFamily: 'Viga',
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Center(
                child: Text(
                  'Deliver Favorite Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter_SemiBold',
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
