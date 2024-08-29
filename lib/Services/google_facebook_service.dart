import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static bool isloading = false;
  static bool isError = false;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/user.phonenumbers.read',
    ],
  );
  static Future<Map<String, dynamic?>> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Retrieve the email, first name, and last name
        String? email = account.email;
         String? photo = account.photoUrl;
      
        String? firstName = account.displayName?.split(' ')[0];
        String? lastName = account.displayName?.split(' ').last;
        return {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'photo' : photo,
        };
      } else {
        GoogleService.isError = true;
        return {
          'error': GoogleService.isError,
          'details': "An Error Accoured",
        };
      }
    } catch (error) {
      print('Error signing in with Google: $error');
       GoogleService.isError = true;
      return {
        'error': GoogleService.isError,
        'details': "An Error Accoured",
      };
    }
  }
}
