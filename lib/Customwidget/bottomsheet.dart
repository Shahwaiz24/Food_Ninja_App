import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/Screens/login_screen.dart';
import 'package:food_delivery_app/Screens/profile_page.dart';
import 'package:food_delivery_app/Services/local_storage.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Its an Custom Bottom Sheet for Display the User Information to Page//

class PersistentBottomSheet extends StatefulWidget {
  const PersistentBottomSheet({super.key});

  @override
  State<PersistentBottomSheet> createState() => _PersistentBottomSheetState();
}

class _PersistentBottomSheetState extends State<PersistentBottomSheet> {
  bool hasFavourites = false;
  bool isloading = true;

  // Function to Get the Favourite List //
  List<Map<String, dynamic>> Favourite_data = [];

  Future<void> retrivefavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('My_Favourites');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> retrievedList =
          decodedList.cast<Map<String, dynamic>>();
      setState(() {
        Favourite_data = retrievedList;
      });
      print('List retrieved from SharedPreferences: $Favourite_data');

      if (Favourite_data == null || Favourite_data.isEmpty) {
        hasFavourites = false;
      } else if (Favourite_data != null || Favourite_data.isNotEmpty) {
        hasFavourites = true;
      }
    } else {
      print('No list found in SharedPreferences');
    }
  }

  int? Index;
// to delete the Favourite Item //
  Future<void> deletefavourite({required Map keyToDelete}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('My_Favourites');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> existingList =
          decodedList.cast<Map<String, dynamic>>();
      existingList.remove(existingList[Index!]);

      String updatedJsonString = json.encode(existingList);

      await prefs.setString('My_Favourites', updatedJsonString);
      print('Map deleted from SharedPreferences List');
      print(updatedJsonString);
    } else {
      print('No list found in SharedPreferences');
    }
  }

  // It is For the Process Of Checking the Favourites//
  Stopwatch _stopwatch = Stopwatch();
  void startFavouritesprocess() {
    // Start the timer
    _stopwatch.start();
    // Call the async function
    retrivefavourites().then((_) {
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
    startFavouritesprocess();
  }

  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    if (isloading == false) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: screenHeight * .6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(screenWidth * 0.080)),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.025,
                top: screenHeight * 0.020,
                right: screenWidth * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * .3,
                      height: screenHeight * 0.045,
                      decoration: BoxDecoration(
                        color: const Color(0xffFEAD1D).withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.024),
                      ),
                      child: Center(
                        child: Text(
                          'Member Gold',
                          style: TextStyle(
                              color: const Color(0xffFEAD1D),
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.017),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () async{
                       await LocalStorage.logoutuser();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        color: linearGreen,
                        size: screenHeight * 0.035,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user_data['userfirstname'] +
                              ' ' +
                              user_data['userlastname'],
                          style: TextStyle(
                              fontSize: screenHeight * 0.030,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins_SemiBold'),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          user_data['useremail'],
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins_Light',
                              fontSize: screenHeight * 0.020,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.edit,
                      color: linearGreen,
                      size: screenHeight * 0.035,
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Container(
                  width: screenWidth * .9,
                  height: screenHeight * 0.070,
                  decoration: BoxDecoration(
                      color: WhiteandBlack,
                      borderRadius: BorderRadius.circular(screenWidth * .1)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.025, right: screenWidth * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage(
                              'assets/images/Voucher_Icon.png'),
                          height: screenHeight * 0.140,
                          width: screenWidth * 0.140,
                        ),
                        SizedBox(
                          width: screenWidth * 0.030,
                        ),
                        Text(
                          'You Have 3 Vouchers',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenHeight * 0.017,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins_SemiBold'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.024,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.050),
                  child: Text(
                    'Favourites',
                    style: TextStyle(
                        fontFamily: 'Poppins_SemiBold',
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                hasFavourites == true
                    ? ListView.builder(
                        itemCount: Favourite_data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            height: screenHeight * 0.110,
                            // margin: EdgeInsets.only(top: 20.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.040),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 3), 
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.010,
                                  right: screenWidth * 0.035,
                                  left: screenWidth * 0.035,
                                  bottom: screenHeight * 0.010),
                              child: Row(
                                children: [
                                  Container(
                                    height: screenHeight * 0.070,
                                    width: screenWidth * 0.160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.026),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                Favourite_data[index]['image']),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.040,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Favourite_data[index]['name'],
                                        style: TextStyle(
                                            fontFamily: 'Poppins_Regular',
                                            fontSize: screenHeight * 0.016,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        Favourite_data[index]['resturant'],
                                        style: TextStyle(
                                            fontFamily: 'Poppins_Regular',
                                            fontSize: screenHeight * 0.014,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[400]),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.008,
                                      ),
                                      Text(
                                        Favourite_data[index]['price']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: screenHeight * 0.020,
                                            fontFamily: 'Poppins_Light',
                                            fontWeight: FontWeight.w500,
                                            color: linearGreen),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          Index = index;

                                          deletefavourite(
                                              keyToDelete:
                                                  Favourite_data[index]);
                                          retrivefavourites();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete_outline_outlined,
                                        size: screenHeight * 0.030,
                                        color: linearGreen,
                                      ))
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        height: screenHeight * 0.080,
                        decoration: BoxDecoration(
                            color: WhiteandBlack,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.030)),
                        child: Center(
                          child: Text(
                            'There is No Item in Your Favourites',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins_Regular',
                                fontSize: screenHeight * 0.016,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (isloading == true) {
      return Center(
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
  }
}
