import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/bottom_navigation.dart';
import 'package:food_delivery_app/Screens/Product_Screen/product_content.dart';
import 'package:food_delivery_app/Screens/data_model.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  int index;

  ProductScreen({super.key, required this.index});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
                  image: NetworkImage(MenuImages[widget.index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ResturantContent below the image
            Positioned(
              bottom: screenHeight * 0.001, // Adjust as needed
              left: 0,
              right: 0,
              child: ProductContent(
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
