import 'dart:io';

import 'package:food_delivery_app/Screens/Signup_Screens/bio_signup.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/check_picture_signup.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/set_location.dart';
import 'package:food_delivery_app/Services/firebase_services.dart';
import 'package:food_delivery_app/main.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

bool isError = false;
File? selectedimage;

final picker = ImagePicker();

class PictureSignUp extends StatefulWidget {
  const PictureSignUp({super.key});

  @override
  State<PictureSignUp> createState() => _PaymentSignUpState();
}

class _PaymentSignUpState extends State<PictureSignUp> {
  // Function to Get Image //

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      selectedimage = File(image!.path);
    });
  }

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
            child: SingleChildScrollView(
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
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.025),
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
                        height: screenHeight * 0.130,
                      ),
                      selectedimage != null
                          ? Center(
                              child: Container(
                                  height: screenHeight * 0.250,
                                  width: screenWidth * .8,
                                  decoration: BoxDecoration(
                                      color: WhiteandBlack,
                                      borderRadius: BorderRadius.circular(
                                          screenHeight * 0.025)),
                                  child: Image.file(
                                    selectedimage!.absolute,
                                    fit: BoxFit.contain,
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isError = false;
                                });
                                _pickImage();
                              },
                              child: Container(
                                height: screenHeight * 0.160,
                                width: screenWidth * .9,
                                decoration: BoxDecoration(
                                    color: WhiteandBlack,
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * 0.025)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/Gallery_Icon.png'),
                                      height: screenHeight * 0.1,
                                      width: screenWidth * 0.2,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "From Gallery",
                                      style: TextStyle(
                                          fontFamily: 'Poppins_SemiBold',
                                          fontWeight: FontWeight.w800,
                                          fontSize: screenHeight * 0.0205),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.020,
                            left: screenWidth * 0.090,
                            right: screenWidth * 0.090),
                        child: isError == true
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: screenHeight * 0.030,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.010,
                                  ),
                                  Text(
                                    'Please Select the Picture',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_Regular',
                                        fontWeight: FontWeight.w300,
                                        fontSize: screenHeight * 0.020),
                                  ),
                                ],
                              )
                            : Text(''),
                      ),
                      SizedBox(
                        height: screenHeight * 0.100,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (selectedimage != null) {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: SetLocationSignUp(),
                                      duration: const Duration(seconds: 1)));
                            } else {
                              setState(() {
                                isError = true;
                              });
                            }
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
            ),
          )
        ],
      ),
    );
  }
}
