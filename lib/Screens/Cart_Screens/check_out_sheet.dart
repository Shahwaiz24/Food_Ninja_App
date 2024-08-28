import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/Cart_Screens/confirm_order.dart';
import 'package:food_delivery_app/Services/local_storage.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

int subtotalPrice = 0;
int finalPrice = 0;

int delivery = 20;
int discount = 5;

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

int calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
  int totalPrice = 0;
  for (var item in cartItems) {
    int quantity = item['quantity'];
    double price = double.parse(item['price']);
    totalPrice += (quantity * price).toInt();
  }
  return totalPrice;
}

int calculateFinalPrice(int subtotalPrice) {
// Assuming discount is in percentage

  // Calculate total price by adding subtotal, delivery charge, and applying discount
  int total = delivery - discount;
  // Round the total to the nearest integer
  int all = total + subtotalPrice.floor();
  int totalPrice = all;

  // Return the total price
  return totalPrice;
}

class _CheckOutState extends State<CheckOut> {
  @override
  void initState() {
    super.initState();
    LocalStorage.fetchCartItems().then((cartItems) {
      calculateAndSetTotalPrice(cartItems);
      finalPrice = calculateFinalPrice(subtotalPrice);
    });
  }

  void calculateAndSetTotalPrice(List<Map<String, dynamic>> cartItems) {
    int newTotalPrice = calculateTotalPrice(cartItems);
    setState(() {
      subtotalPrice = newTotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double buttonWidth = screenWidth * 0.80;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.020),
      child: Container(
        height: screenHeight * 0.240,
        width: screenWidth * 2,
        decoration: BoxDecoration(
            color: linearGreen,
            borderRadius: BorderRadius.circular(screenWidth * 0.040)),
        child: Stack(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Second_Pattern_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.030,
                  right: screenWidth * 0.055,
                  left: screenWidth * 0.055),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sub-Total',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins_Regular',
                            fontWeight: FontWeight.w200,
                            fontSize: screenHeight * 0.018),
                      ),
                      const Spacer(),
                      Text('\$$subtotalPrice',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.018)),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.008,
                  ),
                  Row(
                    children: [
                      Text('Delivery Charge',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.018)),
                      const Spacer(),
                      Text('$delivery\$',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.018)),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.008,
                  ),
                  Row(
                    children: [
                      Text('Discount',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.018)),
                      const Spacer(),
                      Text('$discount\$',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.018)),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.010,
                  ),
                  Row(
                    children: [
                      Text('Total',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.020)),
                      Spacer(),
                      Text('$finalPrice\$',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w200,
                              fontSize: screenHeight * 0.020))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.010,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmOrder()));
                    },
                    child: Container(
                      height: buttonHeigth,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Text(
                        'Place My Order',
                        style: TextStyle(
                          color: linearGreen,
                          fontSize: buttonTitle,
                          fontFamily: 'Poppins_SemiBold',
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              //
            ),
          ],
        ),
      ),
    );
  }
}
