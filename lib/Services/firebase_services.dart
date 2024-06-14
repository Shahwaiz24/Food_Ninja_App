// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:food_delivery_app/Screens/Signup_Screens/picture_signup.dart';

class FirebaseServices {
  static final databaseRef = FirebaseDatabase.instance.ref('Users DataBase');

  static var userImage;
// Function To Sign Up User
  static signUp_User({
    required userSignInPass,
    required userSignInUsername,
    required userSignInEmail,
    required userSignInFirstName,
    required userSignInLastName,
    required userSignInNumber,
    required expiryDate,
    required cvvNumber,
    required cardnumber,
    required city,
    required country,
    required cardname,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userSignInEmail, password: userSignInPass);
    } catch (e) {
      print('Erorr in Auth ${e.toString()}');
    }

    try {
      await ImageUrlGetter.uploadImage(
          image: selectedimage,
          Firstname: userSignInFirstName,
          Lastname: userSignInLastName);
    } catch (e) {
      print('Image error: ${e.toString()}');
    }

    try {
      // ignore: unnecessary_string_interpolations
      await databaseRef.child("$userSignInPass").set({
        'username': userSignInUsername,
        'useremail': userSignInEmail,
        'userpassword': userSignInPass,
        'userfirstname': userSignInFirstName,
        'userlastname': userSignInLastName,
        'usermobilenumber': userSignInNumber,
        'userpaymentmethod': {
          'expirydate': expiryDate,
          'cvv': cvvNumber,
          'cardnumber': cardnumber,
          'cardname': cardname
        },
        'userlocation': {
          'city': city,
          'Country': country,
        },
        'userProfilePhoto': userImage
      });
    } catch (e) {
      print('Error signing up: $e');
    }
  }
}

class ImageUrlGetter {
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static uploadImage(
      {required image,
      required String Firstname,
      required String Lastname}) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('${Firstname} ${Lastname}/Images');

    firebase_storage.UploadTask uploadTask = ref.putFile(image);
    // Wait for the upload to complete
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(downloadUrl);
    if (downloadUrl != null) {
      FirebaseServices.userImage = downloadUrl;
      print(FirebaseServices.userImage);
    }
  }
}
