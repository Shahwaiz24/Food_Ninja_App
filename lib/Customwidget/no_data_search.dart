import 'package:flutter/material.dart';
import 'package:Food_Ninja/Screens/search_page.dart';

class NullSearch extends StatelessWidget {
  const NullSearch({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: screenHeight * 0.130,
            width: screenWidth * .4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/error_image.png'),
                  fit: BoxFit.cover),
            )),
        SizedBox(
          height: 3,
        ),
        Text(
          'Sorry! We Could not Find the $searchdata',
          style: TextStyle(
              fontFamily: 'Poppins_Regular',
              fontSize: screenHeight * 0.020,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          'Try Again!',
          style: TextStyle(
              fontFamily: 'Poppins_Regular',
              fontWeight: FontWeight.w500,
              fontSize: screenHeight * 0.018),
        )
      ],
    );
  }
}
