import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/splash_screen.dart';
import 'package:food_delivery_app/Services/local_storage.dart';
import 'package:food_delivery_app/firebase_options.dart';

Color linearGreen = const Color(0xff15BE77);
Color WhiteandBlack = const Color(0xffF4F4F4);
Color Darkorange = const Color(0xffDA6317);
Color Lightorange = const Color(0xffF9A84D);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await LocalStorage.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
