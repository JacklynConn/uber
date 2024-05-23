import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/common/controller/sevices/profileDataCrudService.dart';
import 'package:uber/common/view/authScreens/loginScreen.dart';
import 'package:uber/common/view/signInLogic/signInLogin.dart';
import 'package:uber/constant/constants.dart';
import 'package:page_transition/page_transition.dart'; // Added this line
import 'package:uber/rider/view/bottomNavBar/bottomNavBarRider.dart';
import '../../view/authScreens/otpScreen.dart';
import '../provider/authProvider.dart';

final _firebaseAuth = FirebaseAuth.instance;
String? _verificationId;

class MobileAuthService {
  static receiveOTP(
      {required BuildContext context, required String mobileNumber}) async {
    var phone = mobileNumber.substring(0, 1) == '0'
        ? mobileNumber.substring(1)
        : mobileNumber;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          log(credential.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
        },
        codeSent: (String verificationCode, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateVerificationCode(verificationCode);
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const OTPScreen(),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationCode!,
        smsCode: otp,
      );
      await _firebaseAuth.signInWithCredential(credential);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SignInLogic(),
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static bool checkAuthentication() {
    User? user = auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  static checkAuthenticationAndNavigate({required BuildContext context}) {
    bool userIsAuthenticated = checkAuthentication();
    userIsAuthenticated
        ? Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const BottomNavBarRider(),
              type: PageTransitionType.rightToLeft,
            ),
            (route) => false,
          )
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.rightToLeft,
            ),
            (route) => false,
          );
  }

  checkUser(BuildContext context) async{
    bool userIsRegistered = await ProfileDataCrudService.checkForRegisteredUser(context);
    if(userIsRegistered == true){

  }
}
