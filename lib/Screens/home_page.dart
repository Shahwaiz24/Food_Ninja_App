import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/bottom_navigation.dart';
import 'package:food_delivery_app/Customwidget/slider.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/profile_ready.dart';
import 'package:food_delivery_app/Screens/menu_page.dart';
import 'package:food_delivery_app/Screens/resturants_page.dart';
import 'package:food_delivery_app/Screens/search_page.dart';
import 'package:food_delivery_app/Services/local_storage.dart';
import 'package:food_delivery_app/main.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

// Its an Home Page of Our Application //

// It is a Global Varaible for Fetching Data //
Map<dynamic, dynamic> user_data = {};

// Function to SET USER lOGIN IN //





class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    LocalStorage.isDataSaved(key: 'user_details');
  }

  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: screenHeight * 0.3,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/Second_Pattern.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.750,
                            top: screenHeight * 0.105,
                          ),
                          child: GestureDetector(
                            child: Container(
                              height: screenHeight * 0.050,
                              width: screenWidth * 0.120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.020),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: badges.Badge(
                                badgeContent: const Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Colors.red,
                                ),
                                child: Icon(Icons.notifications_none_sharp,
                                    color: linearGreen,
                                    size: screenHeight * 0.040),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.060,
                            top: screenHeight * 0.100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find Your",
                                style: TextStyle(
                                  fontFamily: 'Poppins_SemiBold',
                                  fontSize: screenHeight * 0.040,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Favourite Food',
                                style: TextStyle(
                                  fontFamily: 'Poppins_SemiBold',
                                  fontSize: screenHeight * 0.040,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.040,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.020),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchPage()));
                                      },
                                      child: Container(
                                        height: screenHeight * 0.059,
                                        width: screenWidth * 0.750,
                                        decoration: BoxDecoration(
                                          color: Lightorange.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              screenHeight * 0.030),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.040),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.search,
                                                color: Darkorange,
                                                size: screenHeight * 0.025,
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.020,
                                              ),
                                              Text(
                                                'What do you want to order?',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_Light',
                                                  color: Darkorange.withOpacity(
                                                      0.9),
                                                  fontSize:
                                                      screenHeight * 0.018,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * 0.055,
                                    width: screenWidth * 0.120,
                                    decoration: BoxDecoration(
                                      color: Lightorange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                          screenHeight * 0.023),
                                    ),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/Filter_Icon.png"),
                                        height: screenHeight * 0.060,
                                        width: screenWidth * 0.060,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.030,
                              ),
                              Container(
                                height: screenHeight * .2,
                                width: screenWidth * .9,
                                decoration: BoxDecoration(
                                  color: linearGreen,
                                  borderRadius: BorderRadius.circular(
                                      screenHeight * 0.023),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.3,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/Second_Pattern_bg.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/images/Ice_Cream.png'),
                                      width: screenWidth * .4,
                                      height: screenHeight * .5,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.030,
                                        left: screenWidth * .2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.080),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Special Deal For",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'Poppins_SemiBold',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenHeight * 0.026,
                                                  ),
                                                ),
                                                Text(
                                                  "October",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'Poppins_SemiBold',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenHeight * 0.026,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.020,
                                                ),
                                                Container(
                                                  height: screenHeight * 0.050,
                                                  width: screenWidth * 0.220,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            screenWidth *
                                                                0.020),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Buy Now',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Poppins_SemiBold',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: linearGreen,
                                                        fontSize: screenHeight *
                                                            0.016,
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
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.020,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.020),
                                child: Row(
                                  children: [
                                    Text(
                                      "Nearest Resturant",
                                      style: TextStyle(
                                        fontFamily: 'Poppins_SemiBold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.025,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.026),
                                      child: TextButton(
                                        onPressed: () {
                                         Navigator.push(
                                  context,
                              MaterialPageRoute(builder: (context) => ResturantPage() ));
                                        },
                                        child: Text(
                                          'View More',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_Light',
                                            color: Lightorange,
                                            fontSize: screenHeight * 0.017,
                                            fontWeight: FontWeight.w200,
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
                              Slide(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.020,
                                    top: screenHeight * 0.018),
                                child: Row(
                                  children: [
                                    Text(
                                      "Popular Menu",
                                      style: TextStyle(
                                        fontFamily: 'Poppins_SemiBold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.025,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.026),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                  context,
                              MaterialPageRoute(builder: (context) => MenuPage()));
                                        },
                                        child: Text(
                                          'View More',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_Light',
                                            color: Lightorange,
                                            fontSize: screenHeight * 0.017,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.018),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.020),
                                child: Container(
                                  height: screenHeight * 0.130,
                                  width: screenWidth * 0.850,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: WhiteandBlack),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.020,
                                        top: screenHeight * 0.010,
                                        right: screenWidth * 0.020,
                                        bottom: screenHeight * 0.020),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenHeight * 0.090,
                                          width: screenWidth * 0.170,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/MenuImage/Menu_Photo_3.jpg'),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.070,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 05),
                                          child: Text(
                                            'Green Noodle',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins_SemiBold',
                                                fontSize: screenHeight * 0.020,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: screenWidth * 0.020,
                                              bottom: 05),
                                          child: Text(
                                            '15\$',
                                            style: TextStyle(
                                              color: Lightorange,
                                              fontSize: screenHeight * 0.030,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.018),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.020),
                                child: Container(
                                  height: screenHeight * 0.130,
                                  width: screenWidth * 0.850,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: WhiteandBlack),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.020,
                                        top: screenHeight * 0.010,
                                        right: screenWidth * 0.020,
                                        bottom: screenHeight * 0.020),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenHeight * 0.090,
                                          width: screenWidth * 0.170,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/MenuImage/Menu_Photo_2.jpg'),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.070,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 05),
                                          child: Text(
                                            'Herbal Pancake',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins_SemiBold',
                                                fontSize: screenHeight * 0.020,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: screenWidth * 0.020,
                                              bottom: 05),
                                          child: Text(
                                            '15\$',
                                            style: TextStyle(
                                              color: Lightorange,
                                              fontSize: screenHeight * 0.030,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.012,
              left: screenWidth * 0.040,
              right: screenWidth * 0.040,
              child: BottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }
}
