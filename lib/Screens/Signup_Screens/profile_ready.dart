import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/get_location.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/payment_box.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/payment_signup.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/picture_signup.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/signup_screen.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bio_signup.dart';
import "package:firebase_auth/firebase_auth.dart";

final auth = FirebaseAuth.instance;
bool isloading = true;
final databaseRef = FirebaseDatabase.instance.ref('Users DataBase');
Map<String, dynamic> savedDetails = {};
Map<dynamic, dynamic> userDetails = {};

// Function To Sign Up User
Future<void> signup() async {
  try {
    await auth.createUserWithEmailAndPassword(
        email: userSignInEmail.toString(), password: userSignInPass.toString());

    // ignore: unnecessary_string_interpolations
    await databaseRef.child("$userSignInPass").set({
      'username': userSignInUsername,
      'useremail': userSignInEmail,
      'userpassword': userSignInPass,
      'userfirstname': userSignInFirstName,
      'userlastname': userSignInLastName,
      'usermobilenumber': userSignInNumber,
      'userpaymentmethod': {
        'expirydate': expiryDate,
        'cvv': cvvNumber,
        'cardnumber': cardnumber,
      },
      'profilepicture': selectedimage.toString(),
      'userlocation': {
        'city': city,
        'street': street,
      }
    });
  } catch (e) {
    print('Error signing up: $e');
  }
}

// Function to save map to SharedPreferences
Future<void> saveuserdata(
    {required String key, required Map<dynamic, dynamic> data}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Convert map to JSON string
  String jsonString = jsonEncode(data);
  // Save JSON string to SharedPreferences
  await prefs.setString(key, jsonString);
}

// Function to Get Data of User //
Future<Map<dynamic, dynamic>?> fetchuserdata({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(key);
  if (jsonString != null) {
    savedDetails = jsonDecode(jsonString);

    return user_data = savedDetails;
  } else {
    // If no data found, return null
    return null;
  }
}
// Function end //

class ProfileReady extends StatefulWidget {
  const ProfileReady({super.key});

  @override
  State<ProfileReady> createState() => _ProfileReadyState();
}

class _ProfileReadyState extends State<ProfileReady> {
// it is for the Signup Process //
  Stopwatch _stopwatch = Stopwatch();
  void startSignupProcess() {
    // Start the timer
    _stopwatch.start();
    // Call the async function
    signup().then((_) {
      // When the async function completes, stop the timer
      _stopwatch.stop();
      // Set isLoading to false once data loading is complete
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startSignupProcess();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Responsives Designs //
    final double buttonFontSize = screenWidth * 0.05;
    return StreamBuilder(
        stream: databaseRef.child(userSignInPass.toString()).onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (isloading == true) {
            return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: linearGreen,
                strokeWidth: 3,
              )),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: linearGreen,
                strokeWidth: 3,
              ),
            );
          } else if (snapshot.hasData) {
            userDetails = snapshot.data.snapshot.value;
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
                            image:
                                AssetImage('assets/images/Splash_Gradient.jpg'),
                            opacity: 0.9,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * .3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Image(
                              image:
                                  AssetImage('assets/images/Check_Profile.jpg'),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Center(
                            child: Text(
                              'Congrats',
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
                              'Your Profile Is Ready To Use',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins_SemiBold',
                                fontSize: screenHeight * 0.025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * .1),
                            child: InkWell(
                              onTap: () {
                                setUserLoggedIn();
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: HomePage(),
                                        duration: const Duration(seconds: 1)));
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
                                  'Try Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: buttonFontSize,
                                      fontFamily: 'Poppins_SemiBold',
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
          }

          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            Center(
              child: CircularProgressIndicator(
                color: linearGreen,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: linearGreen,
            ),
          );
        });
  }
}
