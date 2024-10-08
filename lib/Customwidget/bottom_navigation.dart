import 'package:flutter/material.dart';
import 'package:Food_Ninja/Screens/Cart_Screens/order_details_screen.dart';

import 'package:Food_Ninja/Screens/home_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:Food_Ninja/Screens/profile_page.dart';
import 'package:Food_Ninja/main.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return SafeArea(
      child: Container(
        height: screenHeight * 0.090,
        padding: EdgeInsets.all(screenWidth * 0.018),
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.050, right: screenWidth * 0.050),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  width: 112,
                  height: 45,
                  decoration: BoxDecoration(
                      color: linearGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(screenWidth * 0.028)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: linearGreen,
                            size: 25,
                          ),
                          SizedBox(
                            width: screenWidth * 0.016,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                fontFamily: 'Poppins_Regular',
                                fontSize: screenHeight * 0.017,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  icon: Icon(
                    Icons.person,
                    size: 28,
                    color: linearGreen.withOpacity(0.5),
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen()));
                },
                child: Center(
                    child: badges.Badge(
                  badgeContent:  Center(
                    child: Text(
                      cartitems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  child: Icon(Icons.shopping_cart_outlined,
                      color: linearGreen.withOpacity(0.5), size: 28),
                )),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message_sharp,
                    size: 28,
                    color: linearGreen.withOpacity(0.5),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
