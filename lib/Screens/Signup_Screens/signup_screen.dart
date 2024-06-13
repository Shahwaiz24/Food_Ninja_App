import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/login_screen.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/bio_signup.dart';
import 'package:food_delivery_app/main.dart';
import 'package:page_transition/page_transition.dart';

// Final Assigned Values //
String userSignInEmail = '';
String userSignInPass = '';
String userSignInUsername = '';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Assigned Values//
  bool isErrorUsername = false;
  bool isErrorUserpass = false;
  bool isErrorUseremail = false;
  String errorUsernamemsg = '';
  String errorPassmsg = '';
  String errorUseremailmsg = '';
  String? username;
  String? useremail;
  String? userpass;

  // Controllers //
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FirebaseDatabase database = FirebaseDatabase.instance;

// Function to check if a child node exists in "User DataBase" node
    Future<bool> doesChildNodeExist(String childName) async {
      DatabaseReference userDatabaseRef =
          database.reference().child('Users DataBase');
      DataSnapshot snapshot = await userDatabaseRef.child(childName).get();
      return snapshot.exists;
    }

    void checkUserExistence(String userpass) async {
      bool userExists = await doesChildNodeExist(userpass);
      if (userExists) {
        setState(() {
          usernameController.clear();
          useremailController.clear();
          userpassController.clear();
          isErrorUseremail = true;
          errorUseremailmsg = 'Email Already Exists';
        });
      } else {
        userSignInEmail = useremail!;
        userSignInPass = userpass;
        userSignInUsername = username!;
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: BioSignUp(),
                duration: const Duration(seconds: 1)));
      }
    }

// Responsives Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Calculate responsive font sizes
    final double titleFontSize = screenWidth * 0.06;
    final double buttonFontSize = screenWidth * 0.05;
    final double descriptiveFontSize = screenWidth * 0.04;
    final double logoTitleFontSize = screenWidth * 0.1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Splash_Pattern.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.4),
            child: Container(
              height: screenHeight * 0.37,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Splash_Gradient.jpg'),
                    opacity: 0.9),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                    child: Image(
                  image: AssetImage('assets/images/Logo.jpg'),
                )),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Center(
                    child: Text(
                  'Food Ninja',
                  style: TextStyle(
                      color: linearGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: logoTitleFontSize,
                      fontFamily: 'Viga'),
                )),
                SizedBox(
                  height: screenHeight * 0.004,
                ),
                Center(
                    child: Text(
                  'Deliever Favorite Food',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter_SemiBold',
                      fontSize: descriptiveFontSize,
                      fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: screenHeight * 0.020,
                ),
                Center(
                    child: Text('Signup For Free',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Viga',
                            fontSize: titleFontSize,
                            letterSpacing: 0.5))),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Container(
                    height: screenHeight * 0.080,
                    width: screenWidth * 0.900,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isErrorUsername = false;
                          username = value;
                        });
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Image(
                          image: const AssetImage(
                              'assets/images/Profile_Icon.png'),
                          width: screenWidth * 0.040,
                          height: screenHeight * 0.040,
                        ),
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins_Regular'),
                        fillColor: WhiteandBlack,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: isErrorUsername == true
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
                      left: screenWidth * 0.06, top: screenHeight * 0.005),
                  child: isErrorUsername == true
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
                            Text(
                              errorUsernamemsg,
                              style: const TextStyle(
                                  fontFamily: 'Poppins_Regular',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        )
                      : const Text(''),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.06,
                      left: screenWidth * 0.06,
                      top: screenWidth * 0.0005),
                  child: Container(
                    height: screenHeight * 0.080,
                    width: screenWidth * 0.900,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isErrorUseremail = false;
                          useremail = value;
                        });
                      },
                      controller: useremailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Image(
                          image: const AssetImage(
                              'assets/images/Message_Icon.png'),
                          width: screenWidth * 0.040,
                          height: screenHeight * 0.040,
                        ),
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins_Regular'),
                        fillColor: WhiteandBlack,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: isErrorUseremail == true
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
                      left: screenWidth * 0.06, top: screenHeight * 0.005),
                  child: isErrorUseremail == true
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
                            Text(errorUseremailmsg,
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
                      right: screenWidth * 0.06,
                      left: screenWidth * 0.06,
                      top: screenWidth * 0.0005),
                  child: Container(
                    height: screenHeight * 0.080,
                    width: screenWidth * 0.900,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          isErrorUserpass = false;
                          userpass = value;
                        });
                      },
                      controller: userpassController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        prefixIcon: Image(
                          image: const AssetImage('assets/images/Lock.png'),
                          width: screenWidth * 0.040,
                          height: screenHeight * 0.040,
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins_Regular'),
                        fillColor: WhiteandBlack,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: isErrorUserpass == true
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
                      left: screenWidth * 0.06, top: screenHeight * 0.001),
                  child: isErrorUserpass == true
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
                            Text(errorPassmsg,
                                style: const TextStyle(
                                    fontFamily: 'Poppins_Regular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)),
                          ],
                        )
                      : const Text(''),
                ),
                SizedBox(
                  height: screenHeight * 0.0005,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.040, top: screenHeight * 0.0005),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(
                            image: const AssetImage(
                                'assets/images/Check_List_Icon.png'),
                            height: screenHeight * 0.060,
                            width: screenWidth * 0.060,
                          ),
                          SizedBox(
                            width: screenWidth * 0.018,
                          ),
                          Text(
                            "Keep Me Signed In",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Poppins_Regular',
                                fontSize: descriptiveFontSize),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.0005,
                      ),
                      Row(
                        children: [
                          Image(
                            image: const AssetImage(
                                'assets/images/Check_List_Icon.png'),
                            height: screenHeight * 0.060,
                            width: screenWidth * 0.060,
                          ),
                          SizedBox(
                            width: screenWidth * 0.018,
                          ),
                          Text(
                            "Email me About Special Pricing",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Poppins_Regular',
                                fontSize: descriptiveFontSize),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.010,
                ),
                InkWell(
                  onTap: () {
                    if ((useremail == null || useremail!.isEmpty) &&
                        (username == null || username!.isEmpty) &&
                        (userpass == null || userpass!.isEmpty)) {
                      setState(() {
                        useremailController.clear();
                        usernameController.clear();
                        userpassController.clear();
                        isErrorUseremail = true;
                        isErrorUsername = true;
                        isErrorUserpass = true;
                        errorPassmsg =
                            'Password Must be Greater Than 8 Characters';
                        errorUseremailmsg = 'Email must Ends With @gmail.com';
                        errorUsernamemsg = 'Username must Contains Underscore';
                      });
                    } else if (username != null ||
                        username!.isNotEmpty && userpass != null ||
                        userpass!.isNotEmpty &&
                            useremail != null &&
                            useremail!.isNotEmpty) {
                      // Now Start The Nested If Else for Siginup Without Having Any Null Value //
                      if (!useremail!.endsWith('@gmail.com') &&
                          userpass!.length < 8 &&
                          !username!.contains('_')) {
                        setState(() {
                          useremailController.clear();
                          usernameController.clear();
                          userpassController.clear();
                          isErrorUseremail = true;
                          isErrorUsername = true;
                          isErrorUserpass = true;
                          errorUseremailmsg = 'Email must Ends With @gmail.com';
                          errorUsernamemsg =
                              'Username must Contains Underscore';
                          errorPassmsg =
                              'Password Must be Greater Than 8 Characters';
                        });
                      } else if (useremail!.endsWith('@gmail.com') &&
                          !username!.contains('_') &&
                          userpass!.length >= 8) {
                        setState(() {
                          useremailController.clear();
                          usernameController.clear();
                          userpassController.clear();
                          errorUsernamemsg =
                              'Username must Contains Underscore';
                          isErrorUsername = true;
                        });
                      } else if (useremail!.endsWith('@gmail.com') &&
                          !username!.contains('_') &&
                          userpass!.length < 8) {
                        setState(() {
                          useremailController.clear();
                          usernameController.clear();
                          userpassController.clear();

                          isErrorUsername = true;
                          isErrorUserpass = true;

                          errorUsernamemsg =
                              'Username must Contains Underscore';
                          errorPassmsg =
                              'Password Must be Greater Than 8 Characters';
                        });
                      } else if (!useremail!.endsWith('@gmail.com') &&
                          username!.contains('_') &&
                          userpass!.length < 8) {
                        setState(() {
                          useremailController.clear();
                          usernameController.clear();
                          userpassController.clear();
                          isErrorUseremail = true;

                          isErrorUserpass = true;
                          errorUseremailmsg = 'Email must Ends With @gmail.com';

                          errorPassmsg =
                              'Password Must be Greater Than 8 Characters';
                        });
                      } else if (!useremail!.endsWith('@gmail.com') &&
                          !username!.contains('_') &&
                          userpass!.length >= 8) {
                        setState(() {
                          useremailController.clear();
                          usernameController.clear();
                          userpassController.clear();
                          isErrorUsername = true;
                          isErrorUseremail = true;
                          errorUseremailmsg = 'Email must Ends With @gmail.com';
                          errorUsernamemsg =
                              'Username must Contains Underscore';
                        });
                      } else if (useremail!.endsWith('@gmail.com') &&
                          username!.contains('_') &&
                          userpass!.length >= 8) {
                        setState(() {
                          userSignInEmail = useremail!;
                          userSignInPass = userpass!;
                          userSignInUsername = username!;
                        });

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BioSignUp()));
                      }
                    } else if (userpass != null ||
                        userpass!.isNotEmpty && useremail == null ||
                        useremail!.isEmpty && username == null ||
                        username!.isEmpty) {
                      setState(() {
                        useremailController.clear();
                        usernameController.clear();
                        userpassController.clear();
                        isErrorUseremail = true;
                        isErrorUsername = true;
                        isErrorUserpass = true;
                        errorUseremailmsg = 'Email must Ends With @gmail.com';
                        errorUsernamemsg = 'Username must Contains Underscore';
                        errorPassmsg =
                            'Password Must be Greater Than 8 Characters';
                      });
                    } else if ((useremail != null || useremail!.isNotEmpty) &&
                        (username == null || username!.isEmpty) &&
                        (userpass == null || userpass!.isEmpty)) {
                      setState(() {
                        useremailController.clear();
                        usernameController.clear();
                        userpassController.clear();
                        isErrorUseremail = true;
                        isErrorUsername = true;
                        isErrorUserpass = true;
                        errorUseremailmsg = 'Email must Ends With @gmail.com';
                        errorUsernamemsg = 'Username must Contains Underscore';
                        errorPassmsg =
                            'Password Must be Greater Than 8 Characters';
                      });
                    } else if ((useremail != null || useremail!.isNotEmpty) &&
                        (username != null || username!.isNotEmpty) &&
                        (userpass == null || userpass!.isEmpty)) {
                      setState(() {
                        useremailController.clear();
                        usernameController.clear();
                        userpassController.clear();
                        isErrorUseremail = true;
                        isErrorUsername = true;
                        isErrorUserpass = true;
                        errorUseremailmsg = 'Email must Ends With @gmail.com';
                        errorUsernamemsg = 'Username must Contains Underscore';
                        errorPassmsg =
                            'Password Must be Greater Than 8 Characters';
                      });
                    } else if ((useremail == null || useremail!.isEmpty) &&
                        (username != null || username!.isNotEmpty) &&
                        (userpass == null || userpass!.isEmpty)) {
                      setState(() {
                        useremailController.clear();
                        usernameController.clear();
                        userpassController.clear();
                        isErrorUseremail = true;
                        isErrorUsername = true;
                        isErrorUserpass = true;
                        errorUseremailmsg = 'Email must Ends With @gmail.com';
                        errorUsernamemsg = 'Username must Contains Underscore';
                        errorPassmsg =
                            'Password Must be Greater Than 8 Characters';
                      });
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                      color: linearGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                          fontFamily: 'Poppins_SemiBold',
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const LoginScreen(),
                                duration: const Duration(seconds: 1)));
                      },
                      child: Text(
                        'already have an account?',
                        style: TextStyle(
                            fontFamily: 'Poppins_Regular',
                            fontSize: descriptiveFontSize,
                            color: linearGreen,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

// Responsives Designs //
// final Size screenSize = MediaQuery.of(context).size;
// final double screenHeight = screenSize.height;
// final double screenWidth = screenSize.width;

// final double titleFontSize = screenWidth * 0.06;
// final double buttonFontSize = screenWidth * 0.04;
// final double descriptiveFontsize = screenWidth * 0.04;
// final double logoTitleFontsize = screenWidth * 0.1;
