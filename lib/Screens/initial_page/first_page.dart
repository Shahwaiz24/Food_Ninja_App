import 'package:flutter/material.dart';
import 'package:Food_Ninja/Screens/initial_page/second_page.dart';
import 'package:Food_Ninja/main.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive heights and font sizes
    final double imageHeight = screenHeight * 0.5;
    final double titleFontSize = screenWidth * 0.06;
    // ignore: unused_local_variable
    final double subTitleFontSize = screenWidth * 0.05;
    final double descriptionFontSize = screenWidth * 0.042;
    final double buttonWidth = screenWidth * 0.35;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/First_Page_image.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Find Your Comfort',
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
                      'Food Here',
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
                      'Here You Can find a chef or dish for',
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
                      'every taste and color. Enjoy!',
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
                            MaterialPageRoute(
                                builder: (context) => SecondPage()));
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
            ),
          ],
        ),
      ),
    );
  }
}
