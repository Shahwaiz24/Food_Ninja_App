import 'package:firebase_database/firebase_database.dart';

class FirebaseServices {
  static final databaseRef = FirebaseDatabase.instance.ref('Users DataBase');

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
          'cardname' : cardname
        },
        'userlocation': {
          'city': city,
          'Country': country,
        }
      });
    } catch (e) {
      print('Error signing up: $e');
    }
  }
}
