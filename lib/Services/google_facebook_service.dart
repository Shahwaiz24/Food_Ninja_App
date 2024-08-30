import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleandFacebookService {
  static bool isloading = false;
  static bool isError = false;
  static bool isFacebookerror = false;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/user.phonenumbers.read',
    ],
  );
  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      GoogleandFacebookService.isFacebookerror = false;
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Retrieve the email, first name, and last name
        String? email = account.email;
      

        String? firstName = account.displayName?.split(' ')[0];
        String? lastName = account.displayName?.split(' ').last;
        return {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
         
        };
      } else {
        GoogleandFacebookService.isError = true;
        return {
          'error': GoogleandFacebookService.isError,
          'details': "   An Error Accoured \n Google SignIn Failed",
        };
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      GoogleandFacebookService.isError = true;
      return {
        'error': GoogleandFacebookService.isError,
        'details': "   An Error Accoured \n Google SignIn Failed",
      };
    }
  }

  static Future<Map<String, dynamic?>> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final OAuthCredential facebookauth =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.instance
            .getUserData(fields: "email, first_name, last_name");

        // Retrieve user data
        String? email = userData['email'];
        String? firstName = userData['first_name'];
        String? lastName = userData['last_name'];

        return {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        };
      } else {
        GoogleandFacebookService.isError = true;
        GoogleandFacebookService.isFacebookerror = true;
        return {
          'error': GoogleandFacebookService.isError,
          'details': "     An Error Accoured \n Facebook SignIn Failed",
        };
      }
    } catch (error) {
      print('Error signing in with Facebook: $error');
      GoogleandFacebookService.isError = true;
      GoogleandFacebookService.isFacebookerror = true;

      return {
        'error': GoogleandFacebookService.isError,
        'details': "     An Error Accoured \n Facebook SignIn Failed",
      };
    }
  }
}
