import 'package:flutter/material.dart';
import 'package:Food_Ninja/Customwidget/bottom_navigation.dart';
import 'package:Food_Ninja/Customwidget/slider.dart';
import 'package:Food_Ninja/Screens/Product_Screen/product_screen.dart';
import 'package:Food_Ninja/Screens/data_model.dart';
import 'package:Food_Ninja/Screens/menu_page.dart';
import 'package:Food_Ninja/Screens/resturants_page.dart';
import 'package:Food_Ninja/Screens/search_page.dart';
import 'package:Food_Ninja/Services/local_storage.dart';
import 'package:Food_Ninja/main.dart';
import 'package:badges/badges.dart' as badges;

// Its an Home Page of Our Application //

// It is a Global Varaible for Fetching Data //
Map<dynamic, dynamic> user_data = {};

// It is for Fetching Data //

bool isFetching = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      isFetching = true;
    });
    LocalStorage.fetchuserdata(key: 'user_details');
    print(user_data);
    setState(() {
      isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: SafeArea(
        child: isFetching == true
            ? Center(
                child: CircularProgressIndicator(
                  color: linearGreen,
                ),
              )
            : Stack(
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
                                      borderRadius: BorderRadius.circular(
                                          screenHeight * 0.020),
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
                                      child: Icon(
                                          Icons.notifications_none_sharp,
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
                                                color: Lightorange.withOpacity(
                                                    0.2),
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                                      size:
                                                          screenHeight * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          screenWidth * 0.020,
                                                    ),
                                                    Text(
                                                      'What do you want to order?',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Poppins_Light',
                                                        color: Darkorange
                                                            .withOpacity(0.9),
                                                        fontSize: screenHeight *
                                                            0.018,
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
                                              image: const AssetImage(
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
                                                      left:
                                                          screenWidth * 0.080),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Special Deal For",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Poppins_SemiBold',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenHeight *
                                                                  0.026,
                                                        ),
                                                      ),
                                                      Text(
                                                        "October",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Poppins_SemiBold',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenHeight *
                                                                  0.026,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.020,
                                                      ),
                                                      Container(
                                                        height: screenHeight *
                                                            0.050,
                                                        width:
                                                            screenWidth * 0.220,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  screenWidth *
                                                                      0.020),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset:
                                                                  Offset(0, 3),
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
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  linearGreen,
                                                              fontSize:
                                                                  screenHeight *
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
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.020),
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
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ResturantPage()));
                                              },
                                              child: Text(
                                                'View More',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_Light',
                                                  color: Lightorange,
                                                  fontSize:
                                                      screenHeight * 0.020,
                                                  fontWeight: FontWeight.w600,
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
                                    const Slide(),
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
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: screenWidth * 0.026),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MenuPage()));
                                              },
                                              child: Text(
                                                'View More',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_Light',
                                                  color: Lightorange,
                                                  fontSize:
                                                      screenHeight * 0.020,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: MenuName.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.020,
                                                right: screenWidth * 0.060,
                                                bottom: screenHeight * 0.030),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductScreen(
                                                                index: index)));
                                              },
                                              child: Container(
                                                height: screenHeight * 0.130,
                                                width: screenWidth * 0.850,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: WhiteandBlack),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: screenWidth * 0.020,
                                                      top: screenHeight * 0.010,
                                                      right:
                                                          screenWidth * 0.020,
                                                      bottom:
                                                          screenHeight * 0.020),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: screenHeight *
                                                            0.090,
                                                        width:
                                                            screenWidth * 0.170,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  Menu_Photos[
                                                                      index]),
                                                              fit:
                                                                  BoxFit.cover),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.070,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 05),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              MenuName[index],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins_SemiBold',
                                                                  fontSize:
                                                                      screenHeight *
                                                                          0.020,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.003,
                                                            ),
                                                            Text(
                                                              MenuName[index],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins_Regular',
                                                                  fontSize:
                                                                      screenHeight *
                                                                          0.018,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: screenWidth *
                                                                0.020,
                                                            bottom: 05),
                                                        child: Text(
                                                          '${Prices[index]}\$',
                                                          style: TextStyle(
                                                            color: Lightorange,
                                                            fontSize:
                                                                screenHeight *
                                                                    0.030,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    Container(
                                      height: screenHeight * 0.130,
                                      width: screenWidth * 0.850,
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
