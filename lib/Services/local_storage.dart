import 'dart:convert';

import 'package:food_delivery_app/Customwidget/bottomsheet.dart';
import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> savedDetails = {};
Map<dynamic, dynamic> userDetails = {};

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    print('Initialized');
  }

  static Future<void> setUserLoggedIn() async {
    await prefs.setBool('UserLogined', true);
  }

  static Future<void> setUserLoggedOut() async {
    await prefs.setBool('UserLogined', false);
  }

  static Future<dynamic> isDataSaved({required String key}) async {
    // Check if the key exists in SharedPreferences
    if (prefs.containsKey(key)) {
      // Retrieve the data associated with the key
      String? jsonString = prefs.getString(key);

      if (jsonString != null) {
        // Decode the JSON string into a Map<dynamic, dynamic>
        Map<dynamic, dynamic> data = json.decode(jsonString);

        return user_data = data;
      }
    } else {
      await saveuserdata(key: 'user_details', data: userDetails);
      await fetchuserdata(key: 'user_details');
    }
  }

  static Future<void> deletefavourite({required Map keyToDelete}) async {
    String? jsonString = prefs.getString('My_Favourites');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> existingList =
          decodedList.cast<Map<String, dynamic>>();
      existingList.remove(existingList[Index!]);

      String updatedJsonString = json.encode(existingList);

      await prefs.setString('My_Favourites', updatedJsonString);
      print('Map deleted from SharedPreferences List');
      print(updatedJsonString);
    } else {
      print('No list found in SharedPreferences');
    }
  }

  static Future<bool> checkUserLoggedIn() async {
    bool? isLoggedIn = prefs.getBool('UserLogined');

    return isLoggedIn ?? false;
  }

  static Future<void> retrivefavourites() async {
    String? jsonString = prefs.getString('My_Favourites');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> retrievedList =
          decodedList.cast<Map<String, dynamic>>();

      Favourite_data = retrievedList;

      print('List retrieved from SharedPreferences: $Favourite_data');
      print('Favorites Data: $Favourite_data');

      if (Favourite_data == null || Favourite_data.isEmpty) {
        hasFavourites = false;
      } else if (Favourite_data != null || Favourite_data.isNotEmpty) {
        hasFavourites = true;
      }
    } else {
      print('No list found in SharedPreferences');
    }
  }

  static Future<void> logoutuser() async {
    await prefs.clear();
  }

// Function to save map to SharedPreferences
  static Future<void> saveuserdata(
      {required String key, required Map<dynamic, dynamic> data}) async {
    // Convert map to JSON string
    String jsonString = jsonEncode(data);
    // Save JSON string to SharedPreferences
    await prefs.setString(key, jsonString);
  }

// Function to Get Data of User //
  static Future<Map<dynamic, dynamic>?> fetchuserdata(
      {required String key}) async {
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      savedDetails = jsonDecode(jsonString);

      return user_data = savedDetails;
    } else {
      // If no data found, return null
      return null;
    }
  }
}
