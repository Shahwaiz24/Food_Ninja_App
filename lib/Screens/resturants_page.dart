import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/bottom_navigation.dart';
import 'package:food_delivery_app/Customwidget/gridview.dart';
import 'package:badges/badges.dart' as badges;
import 'package:food_delivery_app/Screens/search_page.dart';

import 'package:food_delivery_app/main.dart';

class ResturantPage extends StatefulWidget {
  const ResturantPage({Key? key}) : super(key: key);

  @override
  State<ResturantPage> createState() => _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage> {
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
                                  // padding: EdgeInsets.only(
                                  //     left: 0.0, top: 5, right: 5)),
                                ),
                                child: Icon(Icons.notifications_none_sharp,
                                    color: linearGreen, size: 33),
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
                                                size: 30,
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
                                height: screenHeight * 0.040,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.020),
                                child: Row(
                                  children: [
                                    Text(
                                      "Popular Restaurants",
                                      style: TextStyle(
                                        fontFamily: 'Poppins_SemiBold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.025,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.030,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomGridView(),
                    Container(
                      height: screenHeight * 0.130,
                      width: screenWidth * 0.850,
                    )
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
