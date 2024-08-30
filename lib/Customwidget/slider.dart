import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:Food_Ninja/Screens/Resturant_Screens/resturant_screen.dart';
import 'package:Food_Ninja/Screens/data_model.dart';
import 'package:Food_Ninja/main.dart';

class Slide extends StatefulWidget {
  const Slide({super.key});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  @override
  Widget build(BuildContext context) {
    //index //

    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return slider.CarouselSlider(
      options: slider.CarouselOptions(
        height: 170.0,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.6,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: imageUrls.asMap().entries.map((entry) {
        final int index = entry.key;
        final String imagePath = entry.value;
        final String name = Names[index];
        final String time = times[index];

        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResturantScreen(index: index)));
              },
              child: Container(
                height: screenHeight * .5,
                width: screenWidth * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenHeight * 0.024),
                  color: WhiteandBlack,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.0001,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Poppins_Semi Bold',
                        fontSize: screenHeight * 0.019,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontFamily: 'Poppins_Regular',
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
