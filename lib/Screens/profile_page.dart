import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/bottom_navigation.dart';
import 'package:food_delivery_app/Customwidget/bottomsheet.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Its an Profile Page who Contains all The Information of User //
bool is_error = false;

// Its an Function to Logout User //

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            child: Container(
              height: screenHeight * 0.090,
              alignment: Alignment.topCenter,
              child: Container(
                height: screenHeight * 0.460,
                width: screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: screenHeight * 0.030,
                  ),
                  child: Image(
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              color: WhiteandBlack,
                              size: screenHeight * 0.030,
                            ),
                            SizedBox(
                              height: screenHeight * 0.020,
                            ),
                            Text(
                              'Network Connection was not Stable',
                              style: TextStyle(
                                  fontFamily: 'Poppins_Regular',
                                  fontSize: screenHeight * 0.024,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      );
                    },
                    image: NetworkImage(user_data['userProfilePhoto']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PersistentBottomSheet(),
          ),
          Positioned(
            bottom: screenHeight * 0.012,
            left: screenWidth * 0.040,
            right: screenWidth * 0.040,
            child: const BottomNavigation(),
          )
        ],
      ),
    );
  }
}
