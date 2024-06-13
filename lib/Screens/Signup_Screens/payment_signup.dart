import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/payment_box.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/picture_signup.dart';
import 'package:food_delivery_app/Screens/data_model.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isError = false;
String? cardname;

int? selected_index;

class PaymentSignUp extends StatefulWidget {
  const PaymentSignUp({super.key});

  @override
  State<PaymentSignUp> createState() => _PaymentSignUpState();
}

class _PaymentSignUpState extends State<PaymentSignUp> {
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
                    height: screenHeight * 0.040,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(
                            fontFamily: 'Poppins_SemiBold',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
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
                        height: 0.010,
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
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: payment_logos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: screenHeight * 0.020),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_index = index;
                                    cardNumberController.clear();
                                    expiryDateController.clear();
                                    cvvController.clear();

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PaymentDialog(
                                          cardName:
                                              payments_name[selected_index!],
                                        );
                                      },
                                    );
                                  });
                                },
                                child: Container(
                                  height: screenHeight * 0.080,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenHeight * 0.025),
                                      color: WhiteandBlack),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image:
                                              AssetImage(payment_logos[index]),
                                          height: screenHeight * 0.8,
                                          width: screenWidth * 0.8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.060),
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
                                    'Please Enter Correct Card Details',
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
                        height: screenHeight * .2,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (cvvNumber != null &&
                                cardNumber != null &&
                                expiryDate != null) {
                              setState(() {
                                cardname = payments_name[selected_index!];
                                print(cardNumber);
                                print(cvvNumber);
                                print(expiryDate);
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PictureSignUp()));
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
