import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/data_model.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductContent extends StatefulWidget {
  final int index_;
  const ProductContent({super.key, required this.index_});

  @override
  State<ProductContent> createState() => _ResturantContentState();
}

// Function to Add Item to Cart //

Future<void> additemtocart({required Map<String, dynamic> item}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Fetching the existing list from SharedPreferences
  String? jsonString = prefs.getString('My_Cart_Items');
  if (jsonString != null) {
    // If existing list is found, decode it
    List<dynamic> decodedList = json.decode(jsonString);
    // Cast each item of decoded list to Map<String, dynamic>
    List<Map<String, dynamic>> existingList =
        decodedList.map((e) => e as Map<String, dynamic>).toList();
    // Add the new item to the existing list
    existingList.add(item);
    // Encode the updated list to JSON
    String updatedJsonString = json.encode(existingList);
    // Save the updated list to SharedPreferences
    await prefs.setString('My_Cart_Items', updatedJsonString);
  } else {
    // If no existing list is found, create a new list with the new item
    List<Map<String, dynamic>> newList = [item];
    // Encode the new list to JSON
    String newJsonString = json.encode(newList);
    // Save the new list to SharedPreferences
    await prefs.setString('My_Cart_Items', newJsonString);
  }
  print('Item Added to Cart');
}

// Fetch Cart Items//
fetchCartItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('My_Cart_Items');
  if (jsonString != null) {
    List<dynamic> decodedList = json.decode(jsonString);
    List<Map<String, dynamic>> cartItems =
        decodedList.map((e) => e as Map<String, dynamic>).toList();
    return cartItems;
  } else {
    return null; // If no items are found, return null
  }
}

// Function to Favourite Item //
bool isfavourite = false;
Future<void> addMapToListInSharedPreferences(
    {required Map<String, dynamic> item}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Fetching the existing list from SharedPreferences
  String? jsonString = prefs.getString('My_Favourites');
  if (jsonString != null) {
    // If existing list is found, decode it
    List<dynamic> decodedList = json.decode(jsonString);
    // Cast each item of decoded list to Map<String, dynamic>
    List<Map<String, dynamic>> existingList =
        decodedList.cast<Map<String, dynamic>>();
    // Add the new item to the existing list
    existingList.add(item);
    print(existingList);
    // Encode the updated list to JSON
    String updatedJsonString = json.encode(existingList);
    // Save the updated list to SharedPreferences
    await prefs.setString('My_Favourites', updatedJsonString);
    // prefs.clear();
  } else {
    // If no existing list is found, create a new list with the new item
    List<Map<String, dynamic>> newList = [item];
    // Encode the new list to JSON
    String newJsonString = json.encode(newList);
    print(newList);
    // Save the new list to SharedPreferences
    await prefs.setString('My_Favourites', newJsonString);
    // prefs.clear();
  }
  print('Map added to SharedPreferences List');
}

class _ResturantContentState extends State<ProductContent> {
  @override
  void initState() {
    super.initState();
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
                          'price': Prices[widget.index_],
                          'resturant': Names[widget.index_]
                        };
                        addMapToListInSharedPreferences(item: ItemtoFav);
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
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<Map<String, dynamic>>? getcart = await fetchCartItems();
                

                  if (getcart == null) {
                    additemtocart(item: {
                      'name': MenuName[widget.index_],
                      'quantity': 1,
                      'price': '${Prices[widget.index_]}',
                      'photo': Menu_Photos[widget.index_],
                      'item_added': true
                    });
                  } else {
                    bool itemFound = false;
                    for (int i = 0; i < getcart.length; i++) {
                      if (getcart[i]['name'] == MenuName[widget.index_]) {
                        setState(() {
                          getcart[i]
                              ['quantity']++; // Increase quantity if item found
                          itemFound = true;
                        });
                        // Encode the updated list to JSON
                        String updatedJsonString = json.encode(getcart);
                        // Save the updated list to SharedPreferences
                        await prefs.setString(
                            'My_Cart_Items', updatedJsonString);
                        print('Item quantity updated in Cart');
                        print(getcart);
                        break;
                      }
                    }

                    if (!itemFound) {
                      additemtocart(item: {
                        'name': MenuName[widget.index_],
                        'quantity': 1,
                        'price': '${Prices[widget.index_]}',
                        'photo': Menu_Photos[widget.index_],
                        'item_added': true
                      });
                    }
                  }
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
