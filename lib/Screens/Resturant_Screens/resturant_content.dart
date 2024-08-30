import 'package:flutter/material.dart';
import 'package:Food_Ninja/Customwidget/custom_list_view.dart';
import 'package:Food_Ninja/Screens/data_model.dart';
import 'package:Food_Ninja/Screens/menu_page.dart';
import 'package:Food_Ninja/main.dart';

class ResturantContent extends StatefulWidget {
  final int index_;
  const ResturantContent({super.key, required this.index_});

  @override
  State<ResturantContent> createState() => _ResturantContentState();
}

class _ResturantContentState extends State<ResturantContent> {
  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Container(
      height: screenHeight * 0.690,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(screenWidth * 0.050)),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.035,
              left: screenWidth * 0.050,
              right: screenWidth * 0.050),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: screenHeight * 0.040,
                    width: screenWidth * 0.200,
                    decoration: BoxDecoration(
                        color: linearGreen.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.035)),
                    child: Center(
                      child: Text(
                        'Popular',
                        style: TextStyle(
                            fontFamily: 'Poppins_Regular',
                            fontSize: screenHeight * 0.016,
                            fontWeight: FontWeight.w600,
                            color: linearGreen),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: screenHeight * 0.100,
                    width: screenWidth * 0.100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: linearGreen.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.location_on_rounded,
                        color: linearGreen,
                        size: screenHeight * 0.030,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                Names[widget.index_].contains('Resto')
                    ? Names[widget.index_]
                    : "${Names[widget.index_]} Resto",
                style: TextStyle(
                  fontSize: screenHeight * 0.030,
                  fontFamily: 'Inter_SemiBold',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.020,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: linearGreen,
                    size: screenHeight * 0.035,
                  ),
                  SizedBox(
                    width: screenWidth * 0.015,
                  ),
                  Text(
                    km[widget.index_],
                    style: TextStyle(
                        fontFamily: 'Poppins_Regular',
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600]),
                  ),
                  SizedBox(
                    width: screenWidth * 0.015,
                  ),
                  Icon(
                    Icons.star_half_rounded,
                    color: linearGreen,
                    size: screenHeight * 0.030,
                  ),
                  Text(
                    rating[widget.index_],
                    style: TextStyle(
                        fontFamily: 'Poppins_Regular',
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.020,
              ),
              Text(
                description[widget.index_],
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins_Light',
                    fontSize: screenHeight * 0.016,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: screenHeight * 0.020,
              ),
              Row(
                children: [
                  Text(
                    'Popular Menu',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins_Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.020),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuPage()));
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          fontFamily: 'Poppins_Light',
                          color: Lightorange,
                          fontSize: screenHeight * 0.017,
                          fontWeight: FontWeight.w200,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomHorizontalList(
                itemCount: MenuName.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MenuPage()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: screenHeight * .2,
                      width: screenWidth * .3,
                      decoration: BoxDecoration(
                          color: WhiteandBlack.withOpacity(0.4),
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.036)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Menu_Photos[index]),
                            width: screenWidth * 0.180,
                            height: screenHeight * 0.110,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            MenuName[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins_Regular',
                                fontSize: screenHeight * 0.017,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${Prices[widget.index_]}\$',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Poppins_Regular',
                                fontSize: screenHeight * 0.016,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
