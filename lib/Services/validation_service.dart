import 'package:flutter/rendering.dart';
import 'package:food_delivery_app/Screens/Signup_Screens/bio_signup.dart';

class ValidationService {
  static String? check_Bio_Validity(
      {required String? firstcheck,
      required String? secondcheck,
      required String? thirdcheck}) {
    if ((firstcheck != null && firstcheck!.isNotEmpty) &&
        (secondcheck != null && secondcheck!.isNotEmpty) &&
        (thirdcheck != null && thirdcheck!.isNotEmpty)) {
      try {
        userSignInNumber = int.parse(thirdcheck);
        print(userSignInNumber);
        return 'All Good';
      } catch (e) {
        return 'Error';
      }
    } else {
      return 'Error';
    }
  }

  static String? check_location_Validity(
      {required String? City, required String? Country, required String? street}) {
    if ((City != null && City.isNotEmpty) &&
        (Country != null && Country.isNotEmpty) && (street != null && street.isNotEmpty)) {
      return 'All Good';
    } else {
      return 'Error';
    }
  }
}
