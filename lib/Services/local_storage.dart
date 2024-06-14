import 'dart:convert';

import 'package:food_delivery_app/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> savedDetails = {};
Map<dynamic, dynamic> userDetails = {};

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
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
      saveuserdata(key: 'user_details', data: userDetails);
      fetchuserdata(key: 'user_details');
    }
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