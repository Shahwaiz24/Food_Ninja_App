import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Resturant_Screens/resturant_screen.dart';

import 'package:food_delivery_app/Screens/data_model.dart';
import 'package:food_delivery_app/main.dart';
import 'package:page_transition/page_transition.dart';

// Its a Custom Widget For Display Grid View //

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 30.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ResturantScreen(
                      index: index,
                    ),
                    duration: const Duration(seconds: 1)));
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.060, right: screenWidth * 0.060),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenHeight * 0.024),
                  color: WhiteandBlack),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(imageUrls[index])),
                  SizedBox(
                    height: 08,
                  ),
                  Text(
                    Names[index],
                    style: TextStyle(
                        fontFamily: 'Poppins_SemiBold',
                        fontSize: screenHeight * 0.020,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 04,
                  ),
                  Text(
                    times[index],
                    style: TextStyle(
                        fontFamily: 'Poppins_Regular',
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
            ),
          ),
        );
      },
    );
  }
}
