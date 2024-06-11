import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/set_location.dart';

import 'package:food_delivery_app/main.dart';
import 'package:page_transition/page_transition.dart';

bool isError = false;

class CheckPictureSignUp extends StatefulWidget {
  const CheckPictureSignUp({super.key});

  @override
  State<CheckPictureSignUp> createState() => _PaymentSignUpState();
}

class _PaymentSignUpState extends State<CheckPictureSignUp> {
  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double buttonWidth = screenWidth * 0.35;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;

    // Payment Function //

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Second_Pattern.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.060, right: screenWidth * 0.060),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.050,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight * 0.025),
                      color: const Color(0xffF9A84D).withOpacity(0.1),
                    ),
                    height: screenHeight * 0.060,
                    width: screenWidth * .14,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: screenWidth * 0.060,
                        color: const Color(0xffDA6317),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Your Profile",
                      style: TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight * 0.040),
                    ),
                    Text(
                      "Photo",
                      style: TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight * 0.040),
                    ),
                    SizedBox(
                      height: screenHeight * 0.020,
                    ),
                    Text(
                      "This data will display in your acount",
                      style: TextStyle(
                          fontFamily: 'Poppins_Regular',
                          fontSize: screenHeight * 0.020,
                          color: Colors.black,
                          fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(
                      height: 0.014,
                    ),
                    Text(
                      "profile for your security",
                      style: TextStyle(
                          fontFamily: 'Poppins_Regular',
                          fontSize: screenHeight * 0.020,
                          color: Colors.black,
                          fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: screenHeight * 0.100,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.080,
                          right: screenWidth * 0.080),
                      child: Container(
                        height: screenHeight * 0.280,
                        width: screenWidth * .9,
                        decoration: BoxDecoration(
                          color: WhiteandBlack,
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.025),
                        ),
                        child: const Center(
                          child: Text(
                            'Sorry! Image Is Not Supported By Web',
                            style: TextStyle(
                                fontFamily: 'Poppins_SemiBold',
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                        // child: selectedimage == null
                        //     ? Text('No image selected.')
                        //     : Image.file(
                        //         File(selectedimage!.path),
                        //         fit: BoxFit.cover,
                        //       ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.100,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const SetLocationSignUp(),
                                  duration: const Duration(seconds: 1)));
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
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildSelectedImageWidget(String? selectedImagePath) {
  return selectedImagePath != null
      ? Image.asset(selectedImagePath, fit: BoxFit.cover)
      : Center(
          child: Text(
            'No image selected',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
}
