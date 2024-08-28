import 'dart:convert';

import 'package:food_delivery_app/Customwidget/bottomsheet.dart';
import 'package:food_delivery_app/Screens/Cart_Screens/order_details_screen.dart';
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
        user_data.clear();
        user_data = data;
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

  static Future<void> removedataofcart() async {
    await prefs.remove('My_Cart_Items');
  }

  static fetchCartItem() async {
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

  static Future<void> addMapToListInSharedPreferences(
      {required Map<String, dynamic> item}) async {
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
      List<Map<String, dynamic>> newList = [];
      newList.add(item);
      // Encode the new list to JSON
      String newJsonString = json.encode(newList);
      print(newList);
      // Save the new list to SharedPreferences
      await prefs.setString('My_Favourites', newJsonString);
      // prefs.clear();
    }
    print('Map added to SharedPreferences List');
  }

  static Future<void> removefavourite(
      {required Map<String, dynamic> item, required int index}) async {
    // Fetching the existing list from SharedPreferences
    String? jsonString = prefs.getString('My_Favourites');
    if (jsonString != null) {
      // If existing list is found, decode it
      List<dynamic> decodedList = json.decode(jsonString);
      // Cast each item of decoded list to Map<String, dynamic>
      List<Map<String, dynamic>> existingList =
          decodedList.cast<Map<String, dynamic>>();
      // Add the new item to the existing list
      existingList.remove(existingList[index]);
      print(existingList);
      // Encode the updated list to JSON
      String updatedJsonString = json.encode(existingList);
      // Save the updated list to SharedPreferences
      await prefs.setString('My_Favourites', updatedJsonString);
      // prefs.clear();
    }
  }

  static Future<void> additemtocart(
      {required Map<String, dynamic> item}) async {
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

  static Future<void> updateitem(
      {required Map<String, dynamic> updatedItem}) async {
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

  static Future<List<Map<String, dynamic>>> fetchCartItems() async {
    String? jsonString = prefs.getString('My_Cart_Items');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> cartItems =
          decodedList.map((e) => e as Map<String, dynamic>).toList();
      return cartItems;
    } else {
      return []; // Return empty list if no items are found
    }
  }

  static Future<void> updateList(List<Map<String, dynamic>> itemList) async {
    String updatedJsonString = json.encode(itemList);
    await prefs.setString('My_Cart_Items', updatedJsonString);
  }

  static CartItems() async {
    String? jsonString = prefs.getString('My_Cart_Items');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);

      cartitems = decodedList.map((e) => e as Map<String, dynamic>).toList();

      is_error = false;

      // Set is_error to false when items are found
    } else if (cartitems.isEmpty || cartitems == []) {
      is_error = true;
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
      user_data.clear();
      savedDetails = jsonDecode(jsonString);

      return user_data = savedDetails;
    } else {
      // If no data found, return null
      return null;
    }
  }
}
