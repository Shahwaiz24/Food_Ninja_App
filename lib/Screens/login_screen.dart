import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/signup_screen.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/main.dart';

Map<String, dynamic> user_details = {};
bool isuser = false;

// Functions End //
// Global Final Values //
String? login_email;
// ignore: non_constant_identifier_names
String? login_password;
String? final_Loginemail;
String? final_Loginpass;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Assigned Values //
  String? errorpass = '';
  String? erroremail = '';
  bool isEmailError = false;
  bool isPassError = false;
  // ignore: non_constant_identifier_names

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  // Function to check if a child node exists in 'Users DataBase' node and return the child's data as a Map or a boolean value if the child does not exist
  final FirebaseDatabase database = FirebaseDatabase.instance;
  Future<Map<dynamic, dynamic>> getuserdata(String childName) async {
    DatabaseReference userDatabaseRef = database.ref().child('Users DataBase');
    DataSnapshot snapshot = await userDatabaseRef.child(childName).get();
    if (snapshot.exists) {
      user_details = snapshot.value as Map<String, dynamic>;
      isuser = true;
      return user_details;
    } else {
      setState(() {
        emailController.clear();
        passController.clear();
        isEmailError = true;
        erroremail = 'User Doesn\'t Exist';
      });
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Define font sizes
    // ignore: unused_local_variable
    final double titleFontSize = screenWidth * 0.06;
    final double buttonFontSize = screenWidth * 0.05;
    FocusNode myFocusNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  fit: BoxFit.fill,
                ),
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
                    opacity: 0.9,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/images/Logo.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
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
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Center(
                    child: Text(
                      'Login To Your Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'Viga',
                        fontSize: screenWidth * 0.06,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          login_email = value;
                          isEmailError = false;
                        });
                      },
                      controller: emailController,
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins_Regular',
                        ),
                        fillColor: WhiteandBlack,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: isEmailError == true
                              ? const BorderSide(color: Colors.red)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.08, top: screenHeight * 0.005),
                    child: isEmailError == true
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
                              Text(erroremail!,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins_Regular',
                                      fontWeight: FontWeight.w700)),
                            ],
                          )
                        : const Text(''),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.005),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          login_password = value;
                          isPassError = false;
                        });
                      },
                      controller: passController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins_Regular',
                        ),
                        fillColor: WhiteandBlack,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: isPassError
                              ? const BorderSide(color: Colors.red)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.08, top: screenHeight * 0.001),
                    child: isPassError == true
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: screenWidth * 0.05,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(errorpass!,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins_Regular',
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          )
                        : const Text(''),
                  ),
                  SizedBox(
                    height: screenHeight * 0.0010,
                  ),
                  Center(
                    child: Text(
                      "Or Continue With",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'Viga',
                        fontSize: screenWidth * 0.05,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.020,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.02, left: screenWidth * 0.010),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: WhiteandBlack),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: screenWidth * 0.40,
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.006),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            'assets/images/Facebook_Icon.jpg'),
                                        height: screenWidth * 0.40,
                                        width: screenWidth * 0.10,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Text(
                                        "Facebook",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.050,
                                          fontFamily: 'Poppins_Regular',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: WhiteandBlack),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: screenWidth * 0.40,
                              height: screenHeight * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.006),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          'assets/images/Google_Icon.jpg'),
                                      height: screenWidth * 0.40,
                                      width: screenWidth * 0.10,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.050,
                                        fontFamily: 'Poppins_Regular',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.030,
                  ),
                  InkWell(
                    onTap: () async {
                      if (login_email != null && login_password != null) {
                        if (login_email!.endsWith('@gmail.com') &&
                            login_password!.length >= 8) {
                          await getuserdata(login_password!);
                          if (isuser == true) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        }
                        if (login_password!.length < 8 &&
                            !login_email!.endsWith('@gmail.com')) {
                          setState(() {
                            isEmailError = true;
                            isPassError = true;
                            passController.clear();
                            errorpass =
                                'Password Must be Greater Than 8 letters';
                            emailController.clear();
                            erroremail = 'Enter Your Email with @gmail.com';
                          });
                        }
                        if (!login_email!.endsWith('@gmail.com') &&
                            login_password!.length >= 8) {
                          setState(() {
                            isEmailError = true;
                            passController.clear();
                            emailController.clear();
                            erroremail = 'Enter Your Email with @gmail.com';
                          });
                        }
                        if (login_password!.length < 8 &&
                            login_email!.endsWith('@gmail.com')) {
                          setState(() {
                            isPassError = true;
                            emailController.clear();
                            passController.clear();
                            errorpass =
                                'Password Must be Greater Than 8 letters';
                          });
                        }
                      }

                      if (login_email == null ||
                          login_email!.isEmpty && login_password == null ||
                          login_password!.isEmpty) {
                        setState(() {
                          isEmailError = true;
                          isPassError = true;
                          emailController.clear();
                          erroremail = 'Email Cannot be Empty';
                          errorpass = 'Password Cannot be Empty';
                          passController.clear();
                        });
                      }
                    },
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.32,
                      decoration: BoxDecoration(
                        color: linearGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonFontSize,
                            fontFamily: 'Poppins_SemiBold',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.010),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          'Create An Account?',
                          style: TextStyle(
                            color: linearGreen,
                            fontFamily: 'Poppins_Regular',
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w700,
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
    );
  }
}
