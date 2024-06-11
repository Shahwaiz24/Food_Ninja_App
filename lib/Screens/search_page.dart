import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/bottom_navigation.dart';
import 'package:food_delivery_app/Customwidget/no_data_search.dart';
import 'package:food_delivery_app/Screens/Product_Screen/product_screen.dart';
import 'package:food_delivery_app/Screens/data_model.dart';
import 'package:food_delivery_app/main.dart';
import 'package:badges/badges.dart' as badges;
import 'package:page_transition/page_transition.dart';

String? searchdata = '';
String? usersearching;
bool isError = false;
bool is_error = false;
late final int Index;

class SearchPage extends StatefulWidget {
  const SearchPage({Key, key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    // size //

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
                            top: screenHeight * 0.100,
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
                          child: SingleChildScrollView(
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
                                      child: Container(
                                        height: screenHeight * 0.059,
                                        width: screenWidth * 0.890,
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
                                              Expanded(
                                                child: TextField(
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      searchdata = value;
                                                    });
                                                  },
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'What do you want to order?',
                                                    hintStyle: TextStyle(
                                                      fontFamily:
                                                          'Poppins_Light',
                                                      color: Darkorange
                                                          .withOpacity(0.9),
                                                      fontSize:
                                                          screenHeight * 0.018,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: is_error == true ? 1 : 4,
                                    // ignore: body_might_complete_normally_nullable
                                    itemBuilder: (context, index) {
                                      if (MenuName[index]
                                          .toLowerCase()
                                          .contains(searchController.text
                                              .toString())) {
                                        final int Index = index;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              searchController.clear();
                                            });
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: ProductScreen(
                                                      index: Index,
                                                    ),
                                                    duration: const Duration(
                                                        seconds: 1)));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: screenHeight * 0.020,
                                              right: screenWidth * 0.060,
                                            ),
                                            child: Container(
                                              height: screenHeight * 0.130,
                                              width: screenWidth * 0.100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  color: WhiteandBlack),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: screenWidth * 0.040,
                                                    left: screenWidth * 0.040),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height:
                                                          screenHeight * 0.090,
                                                      width:
                                                          screenWidth * 0.170,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  Menu_Photos[
                                                                      Index]),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          screenWidth * 0.040,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          MenuName[Index],
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
                                                          height: screenHeight *
                                                              0.003,
                                                        ),
                                                        Text(
                                                          MenuName[Index],
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
                                                    const Spacer(),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            right: screenWidth *
                                                                0.020),
                                                        child: Text(
                                                            '${Prices[index]}\$',
                                                            style: TextStyle(
                                                              color:
                                                                  Lightorange,
                                                              fontSize:
                                                                  screenHeight *
                                                                      0.030,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            )))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (searchController
                                          .text.isEmpty) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              searchController.clear();
                                            });
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: ProductScreen(
                                                      index: index,
                                                    ),
                                                    duration: const Duration(
                                                        seconds: 1)));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: screenHeight * 0.020,
                                              right: screenWidth * 0.060,
                                            ),
                                            child: Container(
                                              height: screenHeight * 0.130,
                                              width: screenWidth * 0.100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  color: WhiteandBlack),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: screenWidth * 0.040,
                                                    left: screenWidth * 0.040),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height:
                                                          screenHeight * 0.090,
                                                      width:
                                                          screenWidth * 0.170,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  Menu_Photos[
                                                                      index]),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          screenWidth * 0.040,
                                                    ),
                                                    Column(
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
                                                          height: screenHeight *
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
                                                    const Spacer(),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            right: screenWidth *
                                                                0.020),
                                                        child: Text(
                                                            '${Prices[index]}\$',
                                                            style: TextStyle(
                                                              color:
                                                                  Lightorange,
                                                              fontSize:
                                                                  screenHeight *
                                                                      0.030,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            )))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    })
                              ],
                            ),
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
