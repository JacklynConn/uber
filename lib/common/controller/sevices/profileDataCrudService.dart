import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber/common/controller/sevices/toastService.dart';
import 'package:uber/common/model/profileDataModel.dart';
import 'package:uber/constant/constants.dart';

class ProfileDataCrudService {
  static getProfileDataFromRealTimeDatabase(String userID) async {
    try {
      final snapshot = await realTimeDatabaseRef.child('User/$userID').get();
      if (snapshot.exists) {
        ProfileDataModel userModel = ProfileDataModel.fromMap(
          jsonEncode(jsonEncode(snapshot.value)) as Map<String, dynamic>,
        );
        return userModel;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> checkForRegisteredUser(BuildContext context) async {
    try {
      final snapshot = await realTimeDatabaseRef
          .child('User/${auth.currentUser!.phoneNumber}')
          .get();
      if (snapshot.exists) {
        log('User Data Found');
        return true;
      }
      log('User Data Not Found');
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static registerUserToDatabase({
    required ProfileDataModel profileData,
    required BuildContext context,
  }) {
    realTimeDatabaseRef
        .child('User/${auth.currentUser!.phoneNumber}')
        .set(profileData.toMap())
        .then((value) {
      ToastService.sendScaffoldAlert(
          msg: 'User Registered Successfully',
          toastStatus: 'SUCCESS',
          context: context);
    }).onError((error, stackTrace) {
      ToastService.sendScaffoldAlert(
          msg: 'Oops! Error getting Registered',
          toastStatus: 'ERROR',
          context: context);
    });
  }

  static Future<bool> userIsDriver(BuildContext context) async {
    try {
      DataSnapshot snapshot = await realTimeDatabaseRef
          .child('User/${auth.currentUser!.phoneNumber}')
          .get();
      if (snapshot.exists) {
        ProfileDataModel userModel = ProfileDataModel.fromMap(
          jsonEncode(jsonEncode(snapshot.value)) as Map<String, dynamic>,
        );
        log('User Type is ${userModel.userType}');
        if (userModel.userType == 'CUSTOMER') {
          return true;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return false;
  }
}
