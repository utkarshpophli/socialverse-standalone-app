import 'dart:math' show Random;
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialverse/export.dart';

class SignUpController extends GetxController {
  final NetworkRepository networkRepository = NetworkRepository();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  create({context}) async {
    Map data = {
      'first_name': firstNameController.text.toString(),
      'last_name': lastNameController.text.toString(),
      'username': usernameController.text.toString(),
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
    };

    var response = await networkRepository.signUp(context, data);

    Get.snackbar(
      response["status"],
      response['message'],
      backgroundColor:
          response['status'] == 'success' ? commonParrot : appColor,
      colorText: primaryWhite,
    );

    if (response['status'] == 'success') {
      Get.to(() => LoginScreen());
    }
  }

  Future<User> signInWithGoogle({context}) async {
    isLoading = true;
    update();
    print(true);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    print('idToken: ' + credential.idToken.toString());
    print('token: ' + credential.token.toString());
    print('accessToken: ' + credential.accessToken.toString());
    print('providerId: ' + credential.providerId.toString());
    print('secret: ' + credential.secret.toString());

    User? user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    IdTokenResult mytoken = await user!.getIdTokenResult();
    String token = mytoken.token.toString();
    log(token.toString());
    // dynamic signInWithCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    // print(signInWithCredential.toString());
    Map data = {
      'token': token,
    };
    var response = await networkRepository.oauth(data, context);
    // log(response.toString());
    if (response['statusCode'] == 200) {
      var responseBody = response['body'];
      dataStorage.write('google', true);
      dataStorage.write('token', responseBody['token']);
      dataStorage.write('balance', responseBody['balance']);
      dataStorage.write('username', responseBody['username']);
      // await Purchases.logIn(dataStorage.read('username'));
      dataStorage.write('email', responseBody['email']);
      dataStorage.write('first_name', responseBody['first_name']);
      dataStorage.write('last_name', responseBody['last_name']);
      dataStorage.write(
          'profile_picture_url', responseBody['profile_picture_url']);
      dataStorage.write('bio', "");
      dataStorage.write("isLogging", true);
      dataStorage.write("isDarkMode", true);
      dataStorage.write("isGridView", true);
      Get.snackbar('Login Successful', 'Welcome to WhitePill',
          backgroundColor: Colors.green, colorText: primaryWhite);
      await Get.offAll(() => MainHomeScreen());
    } else {
      isLoading = false;
      update();
      Get.snackbar('An error occurred', 'Login failed, Please try again',
          backgroundColor: appColor, colorText: primaryWhite);
    }
    isLoading = false;
    update();

    return user;
  }

  Future<User> signInWithApple({context}) async {
    isLoading = true;
    update();
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    print(oauthCredential.idToken);

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    // dynamic response =
    //     await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    User? user =
        (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
            .user;
    IdTokenResult mytoken = await user!.getIdTokenResult();
    String token = mytoken.token.toString();
    log(token.toString());

    Map data = {
      'token': token,
    };
    var response = await networkRepository.oauth(data, context);
    log(response.toString());
    if (response['statusCode'] == 200) {
      var responseBody = response['body'];
      dataStorage.write('apple', true);
      dataStorage.write('token', responseBody['token']);
      dataStorage.write('balance', responseBody['balance']);
      dataStorage.write('username', responseBody['username']);
      // await Purchases.logIn(dataStorage.read('username'));
      dataStorage.write('email', responseBody['email']);
      dataStorage.write('first_name', responseBody['first_name']);
      dataStorage.write('last_name', responseBody['last_name']);
      dataStorage.write(
          'profile_picture_url', responseBody['profile_picture_url']);
      dataStorage.write('bio', "");
      dataStorage.write("isLogging", true);
      dataStorage.write("isDarkMode", true);
      dataStorage.write("isGridView", true);
      Get.snackbar('Login Successful', 'Welcome to WhitePill',
          backgroundColor: Colors.green, colorText: primaryWhite);
      await Get.offAll(() => MainHomeScreen());
    } else {
      isLoading = false;
      update();
      Get.snackbar('An error occurred', 'Login failed, Please try again',
          backgroundColor: appColor, colorText: primaryWhite);
    }
    isLoading = false;
    update();
    // debugPrint(response.toString());
    return user;
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    print(facebookAuthCredential.idToken);
    User? user = (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user;
    IdTokenResult mytoken = await user!.getIdTokenResult();
    String token = mytoken.token.toString();
    // Once signed in, return the UserCredential
    return user;
  }

  void signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  void signOutApple() async {
    await FirebaseAuth.instance.signOut();
  }
}
