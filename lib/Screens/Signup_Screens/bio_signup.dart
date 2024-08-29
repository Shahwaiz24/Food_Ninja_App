import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/payment_signup.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/picture_signup.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/signup_screen.dart';
import 'package:food_delivery_app/Services/google_facebook_service.dart';
import 'package:food_delivery_app/Services/validation_service.dart';
import 'package:food_delivery_app/main.dart';

// Final Bio Values //
String userSignInFirstName = '';
String userSignInLastName = '';
int? userSignInNumber;

String? password;
String? confirmPassword;

class BioSignUp extends StatefulWidget {
  const BioSignUp({super.key, this.isAlready = false});

  final bool isAlready;

  @override
  State<BioSignUp> createState() => _BioSignUpState();
}

class _BioSignUpState extends State<BioSignUp> {
  // Assigned Values //
  bool errorPassword = false;
  String? firstName;
  String errorfirstNamemsg = '';
  bool isfirstNameError = false;
  String? lastName;
  String errorlastNamemsg = '';
  bool issecondNameError = false;
  String? mobileNumber;
  String errormobileNumbermsg = '';
  bool isMobileNumberError = false;

  // Controllers //
  TextEditingController Mobilecontroller = TextEditingController();
  TextEditingController FirstNamecontroller = TextEditingController();
  TextEditingController LastNamecontroller = TextEditingController();
  TextEditingController typePasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              left: screenWidth * 0.060,
            ),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                  widget.isAlready == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fill in your bio to get",
                              style: TextStyle(
                                  fontFamily: 'Poppins_SemiBold',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenHeight * 0.040),
                            ),
                            Text("started",
                                style: TextStyle(
                                    fontFamily: 'Poppins_SemiBold',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenHeight * 0.040)),
                            SizedBox(
                              height: screenHeight * 0.020,
                            ),
                            Text(
                              "This data will be displayed in your acount",
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
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.060,
                                  top: screenWidth * 0.0005),
                              child: Container(
                                height: screenHeight * 0.080,
                                width: screenWidth * 0.900,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      errorPassword = false;
                                    });
                                  },
                                  controller: typePasswordController,
                                  decoration: InputDecoration(
                                    hintText: 'Create a Password',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins_Regular'),
                                    fillColor: WhiteandBlack,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: isfirstNameError == true
                                          ? const BorderSide(color: Colors.red)
                                          : BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.060,
                                  top: screenWidth * 0.0005),
                              child: Container(
                                height: screenHeight * 0.080,
                                width: screenWidth * 0.900,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      errorPassword = false;
                                    });
                                  },
                                  controller: confirmPasswordController,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins_Regular'),
                                    fillColor: WhiteandBlack,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: isfirstNameError == true
                                          ? const BorderSide(color: Colors.red)
                                          : BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.002),
                              child: errorPassword == true
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: screenWidth * 0.05,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text('Password Doesn\'t Match',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_Regular',
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    screenHeight * 0.018)),
                                      ],
                                    )
                                  : const Text(''),
                            ),
                            SizedBox(
                              height: screenHeight * .2,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  password = typePasswordController.text;
                                  confirmPassword =
                                      confirmPasswordController.text;
                                  if ((password == confirmPassword) &&
                                      (password != null &&
                                          confirmPassword != null)) {
                                    userSignInPass = confirmPassword!;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentSignUp()));
                                  } else {
                                    errorPassword = true;
                                    setState(() {});
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
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fill in your bio to get",
                              style: TextStyle(
                                  fontFamily: 'Poppins_SemiBold',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenHeight * 0.040),
                            ),
                            Text("started",
                                style: TextStyle(
                                    fontFamily: 'Poppins_SemiBold',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenHeight * 0.040)),
                            SizedBox(
                              height: screenHeight * 0.020,
                            ),
                            Text(
                              "This data will be displayed in your acount",
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
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.060,
                                  top: screenWidth * 0.0005),
                              child: Container(
                                height: screenHeight * 0.080,
                                width: screenWidth * 0.900,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      isfirstNameError = false;
                                      firstName = value;
                                    });
                                  },
                                  controller: FirstNamecontroller,
                                  decoration: InputDecoration(
                                    hintText: 'First Name',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins_Regular'),
                                    fillColor: WhiteandBlack,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: isfirstNameError == true
                                          ? const BorderSide(color: Colors.red)
                                          : BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.001),
                              child: isfirstNameError == true
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: screenWidth * 0.05,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text(errorfirstNamemsg,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins_Regular',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12)),
                                      ],
                                    )
                                  : const Text(''),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.060,
                                  top: screenWidth * 0.0005),
                              child: Container(
                                height: screenHeight * 0.080,
                                width: screenWidth * 0.900,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      issecondNameError = false;
                                      lastName = value;
                                    });
                                  },
                                  controller: LastNamecontroller,
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins_Regular'),
                                    fillColor: WhiteandBlack,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: issecondNameError == true
                                          ? const BorderSide(color: Colors.red)
                                          : BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.001),
                              child: issecondNameError == true
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: screenWidth * 0.05,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text(errorlastNamemsg,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins_Regular',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12)),
                                      ],
                                    )
                                  : const Text(''),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.060,
                                  top: screenWidth * 0.0005),
                              child: Container(
                                height: screenHeight * 0.080,
                                width: screenWidth * 0.900,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      isMobileNumberError = false;
                                      mobileNumber = value;
                                    });
                                  },
                                  controller: Mobilecontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins_Regular'),
                                    fillColor: WhiteandBlack,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: isMobileNumberError == true
                                          ? const BorderSide(color: Colors.red)
                                          : BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.001),
                              child: isMobileNumberError == true
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: screenWidth * 0.05,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text(errormobileNumbermsg,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins_Regular',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12)),
                                      ],
                                    )
                                  : const Text(''),
                            ),
                            SizedBox(
                              height: screenHeight * .2,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  String? iserror = await ValidationService
                                      .check_Bio_Validity(
                                          firstcheck: firstName,
                                          secondcheck: lastName,
                                          thirdcheck: mobileNumber);

                                  if (iserror == 'Error') {
                                    print('Invalid Values');
                                    setState(() {
                                      Mobilecontroller.clear();
                                      LastNamecontroller.clear();
                                      FirstNamecontroller.clear();
                                      issecondNameError = true;
                                      isMobileNumberError = true;
                                      isfirstNameError = true;
                                      errorfirstNamemsg =
                                          'Enter Your First Name';
                                      errorlastNamemsg = 'Enter Your Last Name';
                                      errormobileNumbermsg =
                                          'Enter Your Mobile Number in Digits';
                                    });
                                  } else if (iserror == 'All Good') {
                                    setState(() {
                                      userSignInFirstName = firstName!;
                                      userSignInLastName = lastName!;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentSignUp()));
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
