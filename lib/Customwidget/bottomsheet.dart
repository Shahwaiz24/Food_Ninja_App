import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/login_screen.dart';
import 'package:food_delivery_app/Services/local_storage.dart';
import 'package:food_delivery_app/main.dart';

// Its an Custom Bottom Sheet for Display the User Information to Page//

// Favourite data List//
List<Map<String, dynamic>> Favourite_data = [];
bool hasFavourites = false;
bool isloading = true;
int? Index;

class PersistentBottomSheet extends StatefulWidget {
  const PersistentBottomSheet({super.key});

  @override
  State<PersistentBottomSheet> createState() => _PersistentBottomSheetState();
}

class _PersistentBottomSheetState extends State<PersistentBottomSheet> {
  // It is For the Process Of Checking the Favourites//
  Stopwatch _stopwatch = Stopwatch();
  void startFavouritesprocess() {
    // Start the timer
    _stopwatch.start();
    // Call the async function
    LocalStorage.retrivefavourites().then((_) {
      // When the async function completes, stop the timer
      _stopwatch.stop();
      // Set isLoading to false once data loading is complete
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startFavouritesprocess();
  }

  @override
  Widget build(BuildContext context) {
    // Getting Size Dimensions //
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    if (isloading == false) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: screenHeight * .6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(screenWidth * 0.080)),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.025,
                top: screenHeight * 0.020,
                right: screenWidth * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * .3,
                      height: screenHeight * 0.045,
                      decoration: BoxDecoration(
                        color: const Color(0xffFEAD1D).withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.024),
                      ),
                      child: Center(
                        child: Text(
                          'Member Gold',
                          style: TextStyle(
                              color: const Color(0xffFEAD1D),
                              fontFamily: 'Poppins_Regular',
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.017),
                        ),
                      ),
                    ),
                   const Spacer(),
                    IconButton(
                      onPressed: () async {
                        await LocalStorage.logoutuser();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                 const LoginScreen()), // Replace NewScreen with your target screen
                          (Route<dynamic> route) =>
                              false, // This will remove all previous routes
                        );
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        color: linearGreen,
                        size: screenHeight * 0.035,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "sdsdsdsdsds",
                          // user_data['userfirstname'] +
                          //     ' ' +
                          //     user_data['userlastname'],
                          style: TextStyle(
                              fontSize: screenHeight * 0.030,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins_Regular'),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          // user_data['useremail'],
                          "sdsdsdsdsds",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins_Light',
                              fontSize: screenHeight * 0.020,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.edit,
                      color: linearGreen,
                      size: screenHeight * 0.035,
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Container(
                  width: screenWidth * .9,
                  height: screenHeight * 0.070,
                  decoration: BoxDecoration(
                      color: WhiteandBlack,
                      borderRadius: BorderRadius.circular(screenWidth * .1)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.025, right: screenWidth * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage(
                              'assets/images/Voucher_Icon.png'),
                          height: screenHeight * 0.140,
                          width: screenWidth * 0.140,
                        ),
                        SizedBox(
                          width: screenWidth * 0.030,
                        ),
                        Text(
                          'You Have 3 Vouchers',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenHeight * 0.017,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins_SemiBold'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.024,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.050),
                  child: Text(
                    'Favourites',
                    style: TextStyle(
                        fontFamily: 'Poppins_SemiBold',
                        fontSize: screenHeight * 0.020,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                hasFavourites == true
                    ? ListView.builder(
                        padding: EdgeInsets.only(top: screenHeight * 0.010),
                        itemCount: Favourite_data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              background: Container(
                                decoration: BoxDecoration(
                                    color : const Color(0xffFF9012),
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
                              direction: DismissDirection.horizontal,
                              key: ValueKey(
                                  Favourite_data[index]['name'].toString()),
                              onDismissed: (direction) async {
                                setState(() {
                                  Index = index;
                                  isloading = true;
                                });

                                await LocalStorage.deletefavourite(
                                    keyToDelete: Favourite_data[index]);
                                await LocalStorage.retrivefavourites();
                                setState(() {
                                  isloading = false;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: screenHeight * 0.025),
                                child: Container(
                                  height: screenHeight * 0.120,
                                  decoration: BoxDecoration(
                                      color: WhiteandBlack,
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.050)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.010,
                                        right: screenWidth * 0.035,
                                        left: screenWidth * 0.035,
                                        bottom: screenHeight * 0.010),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.070,
                                          width: screenWidth * 0.160,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth * 0.026),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      Favourite_data[index]
                                                          ['image']),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.040,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Favourite_data[index]['name'],
                                              style: TextStyle(
                                                  fontFamily:
                                                      'Poppins_SemiBold',
                                                  fontSize:
                                                      screenHeight * 0.019,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.003,
                                            ),
                                            Text(
                                              Favourite_data[index]
                                                  ['resturant'],
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_Light',
                                                  fontSize:
                                                      screenHeight * 0.018,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[500]),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.006,
                                            ),
                                            Text(
                                              "\$ ${Favourite_data[index]['price'].toString()}",
                                              style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.025,
                                                  fontFamily: 'Poppins_Regular',
                                                  fontWeight: FontWeight.w400,
                                                  color: linearGreen),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        })
                    : Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.020),
                        child: Container(
                          height: screenHeight * 0.070,
                          decoration: BoxDecoration(
                              color: WhiteandBlack,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.030)),
                          child: Center(
                            child: Text(
                              'There is No Item in Your Favourites',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins_Regular',
                                  fontSize: screenHeight * 0.019,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                Container(
                  height: screenHeight * 0.100,
                  width: screenWidth * 0.850,
                )
              ],
            ),
          ),
        ),
      );
    } else if (isloading == true) {
      return Center(
        child: CircularProgressIndicator(
          color: linearGreen,
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        color: linearGreen,
      ),
    );
  }
}
