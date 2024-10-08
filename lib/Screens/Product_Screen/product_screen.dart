import 'package:flutter/material.dart';
import 'package:Food_Ninja/Customwidget/bottom_navigation.dart';
import 'package:Food_Ninja/Screens/Product_Screen/product_content.dart';
import 'package:Food_Ninja/Screens/data_model.dart';
import 'package:Food_Ninja/main.dart';

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
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.030,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.010,
                            ),
                            Icon(
                              Icons.error_outline_rounded,
                              color: WhiteandBlack,
                              size: screenHeight * 0.030,
                            ),
                            SizedBox(
                              width: screenWidth * 0.020,
                            ),
                            Text(
                              'Error while Fetching Image',
                              style: TextStyle(
                                  fontFamily: 'Poppins_Regular',
                                  fontSize: screenHeight * 0.021,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    );
                  },
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
