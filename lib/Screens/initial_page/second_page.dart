import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/login_screen.dart';
import 'package:food_delivery_app/main.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Define responsive font sizes
    final double titleFontSize = screenWidth * 0.06;
    // ignore: unused_local_variable
    final double subTitleFontSize = screenWidth * 0.05;
    final double descriptionFontSize = screenWidth * 0.042;
    final double buttonWidth = screenWidth * 0.35;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;
    final double imageheight = screenHeight * 0.5;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Container(
                height: imageheight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Second_Page_image.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Food Ninja is Where Your',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Poppins_SemiBold',
                        fontSize: titleFontSize,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Comfort Food Lives',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Poppins_SemiBold',
                        fontSize: titleFontSize,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Text(
                      'Enjoy a fast and smooth food delivery',
                      style: TextStyle(
                        fontFamily: 'Poppins_Light',
                        fontWeight: FontWeight.w500,
                        fontSize: descriptionFontSize,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'at your doorstep',
                      style: TextStyle(
                        fontFamily: 'Poppins_Light',
                        fontWeight: FontWeight.w500,
                        fontSize: descriptionFontSize,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                                  context,
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        height: buttonHeigth,
                        width: buttonWidth,
                        decoration: BoxDecoration(
                          color: linearGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: buttonTitle,
                              fontFamily: 'Poppins_SemiBold',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
