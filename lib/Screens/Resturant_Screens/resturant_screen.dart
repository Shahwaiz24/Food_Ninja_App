import 'package:flutter/material.dart';
import 'package:Food_Ninja/Customwidget/bottom_navigation.dart';
import 'package:Food_Ninja/Screens/Resturant_Screens/resturant_content.dart';
import 'package:Food_Ninja/Screens/data_model.dart';

// ignore: must_be_immutable
class ResturantScreen extends StatefulWidget {
  int index;

  ResturantScreen({super.key, required this.index});

  @override
  State<ResturantScreen> createState() => _ResturantScreenState();
}

class _ResturantScreenState extends State<ResturantScreen> {
  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Image at the top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              // ignore: sized_box_for_whitespace
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.4, // Adjust the height as needed
                child: Image(
                  image: AssetImage(Resturant_Photo[widget.index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ResturantContent below the image
            Positioned(
              bottom: screenHeight * 0.001, // Adjust as needed
              left: 0,
              right: 0,
              child: ResturantContent(
                index_: widget.index,
              ),
            ),
            // Bottom Navigation
            Positioned(
              bottom: screenHeight * 0.012,
              left: screenWidth * 0.040,
              right: screenWidth * 0.040,
              child: const BottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }
}
