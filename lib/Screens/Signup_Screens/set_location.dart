import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/location_set_widget.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/get_location.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/profile_ready.dart';
import 'package:food_delivery_app/Services/validation_service.dart';
import 'package:food_delivery_app/main.dart';

bool isError = false;
bool isClicked = false;

class SetLocationSignUp extends StatefulWidget {
  const SetLocationSignUp({super.key});

  @override
  State<SetLocationSignUp> createState() => _PaymentSignUpState();
}

class _PaymentSignUpState extends State<SetLocationSignUp> {
  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double buttonWidth = screenWidth * 0.35;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;

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
                    height: screenHeight * 0.020,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set Your Location",
                        style: TextStyle(
                            fontFamily: 'Poppins_SemiBold',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: screenHeight * 0.035,
                            letterSpacing: 0.1),
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
                        height: screenHeight * 0.040,
                      ),
                      isClicked == false
                          ? Container(
                              height: screenHeight * 0.18,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: WhiteandBlack,
                                  borderRadius: BorderRadius.circular(
                                      screenHeight * 0.025)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenWidth * 0.025),
                                        child: Image(
                                          image: const AssetImage(
                                              'assets/images/Location_Logo.png'),
                                          height: screenHeight * .1,
                                          width: screenWidth * .1,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.020),
                                      Text(
                                        "Your Location",
                                        style: TextStyle(
                                            fontFamily: 'Poppins_SemiBold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: screenHeight * 0.024),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: screenHeight * 0.010,),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.020,
                                        left: screenWidth * 0.020,
                                        top: screenWidth * 0.020),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isError = false;
                                          isClicked = true;
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: screenHeight * 0.060,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                screenHeight * 0.025),
                                            color: Colors.white),
                                        child: Center(
                                            child: Text(
                                          "Set Location",
                                          style: TextStyle(
                                              fontFamily: 'Poppins_SemiBold',
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenHeight * 0.022),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : LocationSetTextFields(),
                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.015,
                              right: screenWidth * 0.060),
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
                                      'Please Enter Your Location',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_Regular',
                                          fontWeight: FontWeight.w300,
                                          fontSize: screenHeight * 0.020),
                                    ),
                                  ],
                                )
                              : Text('')),
                      // Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.400),
                        child: InkWell(
                          onTap: () async {
                            // ignore: unused_local_variable
                            String? validation =
                                ValidationService.check_location_Validity(
                                    City: final_City, Country: final_Country);

                            if (validation == 'All Good') {
                              print(validation);
                            } else {
                              print(validation);
                            }
                          },
                          child: Center(
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
