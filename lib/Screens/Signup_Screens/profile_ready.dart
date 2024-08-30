import 'package:flutter/material.dart';
import 'package:Food_Ninja/Customwidget/location_set_widget.dart';
import 'package:Food_Ninja/Screens/Signup_Screens/payment_box.dart';
import 'package:Food_Ninja/Screens/Signup_Screens/payment_signup.dart';
import 'package:Food_Ninja/Screens/Signup_Screens/set_location.dart';
import 'package:Food_Ninja/Screens/Signup_Screens/signup_screen.dart';
import 'package:Food_Ninja/Screens/home_page.dart';
import 'package:Food_Ninja/Services/firebase_services.dart';
import 'package:Food_Ninja/Services/local_storage.dart';
import 'package:Food_Ninja/main.dart';
import 'bio_signup.dart';

bool isloading = true;

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
    FirebaseServices.signUp_User(
            userSignInEmail: userSignInEmail,
            userSignInFirstName: userSignInFirstName,
            userSignInLastName: userSignInLastName,
            userSignInNumber: userSignInNumber,
            userSignInPass: userSignInPass,
            userSignInUsername: userSignInUsername,
            expiryDate: expiryDate,
            city: final_City,
            country: final_Country,
            cvvNumber: cvvNumber,
            cardnumber: cardNumber,
            street: street,
            cardname: cardname)
        .then((_) {
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
        stream: FirebaseServices.databaseRef
            .child(userSignInPass.toString())
            .onValue,
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
                              onTap: () async {
                                userDetails = snapshot.data.snapshot.value;
                                await LocalStorage.saveuserdata(
                                    key: 'user_details', data: userDetails);
                                await LocalStorage.setUserLoggedIn();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
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
