import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Cart_Screens/check_out_sheet.dart';
import 'package:food_delivery_app/Screens/search_page.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> cartitems = [];

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

Future<void> updateList(List<Map<String, dynamic>> itemList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String updatedJsonString = json.encode(itemList);
  await prefs.setString('My_Cart_Items', updatedJsonString);
}

// Function to Update data //
Future<void> updateitem({required Map<String, dynamic> updatedItem}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Fetching the existing list from SharedPreferences
  String? jsonString = prefs.getString('My_Cart_Items');
  if (jsonString != null) {
    List<dynamic> decodedList = json.decode(jsonString);
    List<Map<String, dynamic>> cartItems =
        decodedList.map((e) => e as Map<String, dynamic>).toList();
    // Find the index of the item to update
    int index = cartItems.indexWhere((item) =>
        item['name'] ==
        updatedItem['name']); // Assuming 'name' is the unique identifier
    if (index != -1) {
      // If item found, update it
      cartItems[index] = updatedItem;
      // Encode the updated list to JSON
      String updatedJsonString = json.encode(cartItems);
      // Save the updated list to SharedPreferences
      await prefs.setString('My_Cart_Items', updatedJsonString);
    }
  }
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CartItems();
  }

  bool is_error = false;

  // Function to Fetch Items //
  CartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    String? jsonString = prefs.getString('My_Cart_Items');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);

      cartitems = decodedList.map((e) => e as Map<String, dynamic>).toList();

      setState(() {
        is_error = false;

        // Set is_error to false when items are found
      });
    } else if (cartitems.isEmpty || cartitems == []) {
      setState(() {
        is_error = true;
      });
    }
  }

  void calculateAndSetTotalPrice(List<Map<String, dynamic>> cartItems) {
    int newTotalPrice = calculateTotalPrice(cartItems);
    setState(() {
      subtotalPrice = newTotalPrice;
    });
  }

  void calculatetotalprice() {
    int newtotal = calculateFinalPrice(subtotalPrice);
    setState(() {
      finalPrice = newtotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: screenHeight * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Second_Pattern.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.060,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.050,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight * 0.025),
                      color: const Color(0xffF9A84D).withOpacity(0.1),
                    ),
                    height: screenHeight * 0.060,
                    width: screenWidth * .14,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: screenWidth * 0.060,
                        color: const Color(0xffDA6317),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                is_error == true
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * .2, right: screenWidth * 0.060),
                        child: Center(
                          child: Text(
                            'There is no Item in your Cart',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins_Regular',
                                fontSize: screenHeight * 0.025,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Details',
                            style: TextStyle(
                              fontFamily: 'Poppins_Regular',
                              fontSize: screenHeight * 0.040,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartitems.length,
                  itemBuilder: (context, index) {
                    return is_error == true ||
                            cartitems.isEmpty ||
                            cartitems == []
                        ? Column(
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: WhiteandBlack,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height: screenHeight * .2,
                                  width: screenWidth * .4,
                                  child: Text(
                                    'There is no Item in Your Cart',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.025,
                                        fontFamily: 'Poppins_Regular'),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                right: screenWidth * 0.045,
                                top: screenHeight * 0.020),
                            child: Dismissible(
                              key: ValueKey('${cartitems[index]['name']}'),
                              direction: DismissDirection.horizontal,
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  // Remove the dismissed item from the list
                                  cartitems.removeAt(index);
                                  // Update the list in SharedPreferences
                                  updateList(cartitems);
                                  calculateAndSetTotalPrice(cartitems);
                                  calculatetotalprice();
                                });
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffFF9012),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.050)),
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.030),
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.white,
                                    size: screenHeight * 0.040,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.050),
                                    color: WhiteandBlack),
                                height: screenHeight * 0.120,
                                width: screenWidth * 0.950,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.040,
                                      left: screenWidth * 0.040),
                                  child: Row(children: [
                                    Container(
                                      height: screenHeight * 0.090,
                                      width: screenWidth * 0.170,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  cartitems[index]['photo']),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.035,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartitems[index]['name'],
                                          style: TextStyle(
                                              fontFamily: 'Poppins_SemiBold',
                                              fontSize: screenHeight * 0.020,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.003,
                                        ),
                                        Text(
                                          cartitems[index]['name'],
                                          style: TextStyle(
                                              fontFamily: 'Poppins_Regular',
                                              fontSize: screenHeight * 0.018,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[400]),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.008,
                                        ),
                                        Text(
                                          '\$ ${cartitems[index]['price']}',
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.024,
                                              fontFamily: 'Poppins_Light',
                                              fontWeight: FontWeight.w500,
                                              color: linearGreen),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.008),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (cartitems[index]['quantity'] >
                                                  1) {
                                                setState(() {
                                                  cartitems[index][
                                                      'quantity']--; // Decrease quantity
                                                  updateList(cartitems);
                                                  calculateAndSetTotalPrice(
                                                      cartitems);
                                                  calculatetotalprice(); // Update list in SharedPreferences
                                                });
                                              } else {
                                                print('Cannot Decrease');
                                              }
                                            },
                                            child: Container(
                                              height: screenHeight * 0.032,
                                              width: screenWidth * 0.068,
                                              decoration: BoxDecoration(
                                                  color: linearGreen
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth * 0.020)),
                                              child: Center(
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                      color: linearGreen,
                                                      fontSize:
                                                          screenHeight * 0.025),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.029,
                                          ),
                                          Text(
                                            cartitems[index]['quantity']
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Poppins_Light',
                                                fontSize: screenHeight * 0.018,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.029,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                cartitems[index][
                                                    'quantity']++; // Increase quantity
                                                updateList(cartitems);
                                                calculateAndSetTotalPrice(
                                                    cartitems);
                                                calculatetotalprice();
                                                // Update list in SharedPreferences
                                              });
                                            },
                                            child: Container(
                                              height: screenHeight * 0.032,
                                              width: screenWidth * 0.068,
                                              decoration: BoxDecoration(
                                                  color: linearGreen,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth * 0.020)),
                                              child: Center(
                                                child: Text(
                                                  '+',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          screenHeight * 0.025),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          ),
          is_error == true || cartitems == [] || cartitems.isEmpty
              ? Text('')
              : Positioned(
                  child: CheckOut(),
                  bottom: screenHeight * 0.012,
                  left: screenWidth * 0.040,
                  right: screenWidth * 0.040,
                )
        ],
      )),
    );
  }
}
