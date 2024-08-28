import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Customwidget/bottomsheet.dart';
import 'package:food_delivery_app/Screens/Cart_Screens/order_details_screen.dart';
import 'package:food_delivery_app/Screens/data_model.dart';
import 'package:food_delivery_app/Services/local_storage.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool carted = false;

class ProductContent extends StatefulWidget {
  final int index_;
  const ProductContent({super.key, required this.index_});

  @override
  State<ProductContent> createState() => _ResturantContentState();
}

// Function to Add Item to Cart //

// Function to Favourite Item //
bool isfavourite = false;

class _ResturantContentState extends State<ProductContent> {
  @override
  void initState() {
    super.initState();
    carted = false;
    isfavourite = false;

    for (var i = 0; i < cartitems.length; i++) {
      if (cartitems[i]['index'] == widget.index_) {
        carted = true;
        break;
      }
    }
    for (var i = 0; i < Favourite_data.length; i++) {
      if (Favourite_data[i]['index'] == widget.index_) {
        isfavourite = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //

    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double buttonWidth = screenWidth * 0.80;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;

    return Container(
      height: screenHeight * 0.640,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              screenWidth * 0.050,
            ),
            topRight: Radius.circular(
              screenWidth * 0.050,
            )),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.020,
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
                  SizedBox(
                    width: screenWidth * 0.023,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isfavourite = !isfavourite;
                      });
                      if (isfavourite == true) {
                        Map<String, dynamic> ItemtoFav = {
                          'name': MenuName[widget.index_],
                          'image': Menu_Photos[widget.index_],
                          'index': widget.index_,
                          'price': Prices[widget.index_],
                          'resturant': Names[widget.index_]
                        };
                        LocalStorage.addMapToListInSharedPreferences(
                            item: ItemtoFav);
                      } else if (isfavourite == false) {
                        Map<String, dynamic> itemtodelete = {
                          'name': MenuName[widget.index_],
                          'image': Menu_Photos[widget.index_],
                          'index': widget.index_,
                          'price': Prices[widget.index_],
                          'resturant': Names[widget.index_]
                        };
                        LocalStorage.removefavourite(
                            item: itemtodelete, index: widget.index_);
                        print('Before Delete | ${Favourite_data}');

                        Favourite_data.remove(Favourite_data[widget.index_]);
                        print('After Delete | ${Favourite_data}');
                      }
                    },
                    child: Container(
                      height: screenHeight * 0.100,
                      width: screenWidth * 0.100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isfavourite == true
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2)),
                      child: Center(
                        child: Icon(
                          Icons.favorite_outlined,
                          color: isfavourite == true
                              ? Colors.grey[700]
                              : Colors.red[800],
                          size: screenHeight * 0.030,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                MenuName[widget.index_],
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
                    Icons.shopping_bag_outlined,
                    color: linearGreen,
                    size: screenHeight * 0.030,
                  ),
                  SizedBox(
                    width: screenWidth * 0.015,
                  ),
                  Text(
                    '2000 Orders',
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
                height: screenHeight * 0.080,
              ),
              carted == true
                  ? Center(
                      child: Container(
                        height: buttonHeigth,
                        width: buttonWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonTitle,
                            fontFamily: 'Poppins_SemiBold',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        LocalStorage.additemtocart(item: {
                          'name': MenuName[widget.index_],
                          'index': widget.index_,
                          'quantity': 1,
                          'price': '${Prices[widget.index_]}',
                          'photo': Menu_Photos[widget.index_],
                          'item_added': true
                        });
                        setState(() {
                          carted = true;
                        });

                        // List<Map<String, dynamic>>? getcart =
                        //     await LocalStorage.fetchCartItem();

                        // if (getcart == null) {

                        // } else {
                        //   bool itemFound = false;
                        //   for (int i = 0; i < getcart.length; i++) {
                        //     if (getcart[i]['name'] == MenuName[widget.index_]) {
                        //       setState(() {
                        //  getcart[i][
                        //             'quantity']++; // Increase quantity if item found
                        //         itemFound = true;
                        //       });
                        //       // Encode the updated list to JSON
                        //       String updatedJsonString = json.encode(getcart);
                        //       // Save the updated list to SharedPreferences
                        //       await LocalStorage.prefs.setString(
                        //           'My_Cart_Items', updatedJsonString);
                        //       print('Item quantity updated in Cart');
                        //       print(getcart);
                        //       break;
                        //     }
                        //   }

                        //   if (!itemFound) {
                        //     LocalStorage.additemtocart(item: {
                        //       'name': MenuName[widget.index_],
                        //       'quantity': 1,
                        //       'price': '${Prices[widget.index_]}',
                        //       'photo': Menu_Photos[widget.index_],
                        //       'item_added': true
                        //     });
                        //   }
                        // }
                      },
                      child: Center(
                        child: Container(
                          height: buttonHeigth,
                          width: buttonWidth,
                          decoration: BoxDecoration(
                            color: linearGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: buttonTitle,
                              fontFamily: 'Poppins_SemiBold',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
