import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:food_delivery_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    // Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double buttonWidth = screenWidth * 0.80;
    final double buttonTitle = screenWidth * 0.050;
    final double buttonHeigth = screenHeight * 0.06;

    Future<void> showConfirmationDialog(
        BuildContext context, String message) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/Logo.jpg'),
                      height: screenHeight * 0.080,
                      width: screenWidth * .3,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(
                    message,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenHeight * 0.016,
                        fontFamily: 'Poppins_Regular'),
                  )),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  child: Text('Done'),
                  onPressed: () {
                    setState(() {
                      removedataofcart();
                    });
                   Navigator.pushReplacement(
                                  context,
                              MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
            ],
          );
        },
      );
    }

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
            padding: EdgeInsets.only(left: screenWidth * 0.060),
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
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth * 0.060,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Order',
                        style: TextStyle(
                          fontFamily: 'Poppins_Regular',
                          fontSize: screenHeight * 0.040,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.030,
                      ),
                      Container(
                        height: screenHeight * 0.120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: WhiteandBlack.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.020,
                              left: screenWidth * 0.030,
                              right: screenWidth * 0.030),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deliver To',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Poppins_Regular',
                                    fontSize: screenHeight * 0.016,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w300),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: screenHeight * 0.010),
                                child: Row(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.045,
                                      width: screenWidth * .1,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Location_Logo.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.030,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          user_data['userlocation']['street'],
                                          style: TextStyle(
                                              fontFamily: 'Poppins_SemiBold',
                                              fontSize: screenHeight * 0.018,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.030,
                      ),
                      Container(
                        height: screenHeight * 0.120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: WhiteandBlack.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.020,
                              left: screenWidth * 0.030,
                              right: screenWidth * 0.030),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Method',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Poppins_Regular',
                                    fontSize: screenHeight * 0.016,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w300),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: screenHeight * 0.010),
                                child: Row(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * .3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Paypal_Icon.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Spacer(),
                                    Text(
                                      user_data['userpaymentmethod']
                                              ['cardnumber']
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins_Light',
                                          fontSize: screenHeight * 0.018,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: screenHeight * 0.060,
                        right: screenWidth * 0.060),
                    child: InkWell(
                      onTap: () async {
                        await showConfirmationDialog(
                            context, 'Your Order has been Confirmed!');
                      },
                      child: Container(
                        height: buttonHeigth,
                        width: buttonWidth,
                        decoration: BoxDecoration(
                          color: linearGreen,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          'Place My Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonTitle,
                            fontFamily: 'Poppins_SemiBold',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

// Function to remove data from carts//
Future<void> removedataofcart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('My_Cart_Items');
}
