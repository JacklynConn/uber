import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/common/view/authScreens/loginScreen.dart';
import 'package:uber/common/view/signInLogic/signInLogin.dart';
import 'package:uber/constant/constants.dart';
import 'package:page_transition/page_transition.dart'; // Added this line
import 'package:uber/rider/view/bottomNavBar/bottomNavBarRider.dart';
import 'package:uber/rider/view/homeScreen/riderHomeScreen.dart';
import '../../view/authScreens/otpScreen.dart';
import '../provider/authProvider.dart';

class MobileAuthService {
  static receiveOTP(
      {required BuildContext context, required String mobileNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          log(credential.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
        },
        codeSent: (String verificationCode, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateMobileNumber(verificationCode);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const OTPScreen()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationCode!,
        smsCode: otp,
      );
      await auth.signInWithCredential(phoneAuthCredential);
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: const RiderHomeScreen(),
          type: PageTransitionType.rightToLeft,
        ),
        (route) => false,
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
}
