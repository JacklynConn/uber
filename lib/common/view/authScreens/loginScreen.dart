import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '/common/controller/sevices/mobileAuthService.dart';
import '/constant/utils/colors.dart';
import '/constant/utils/textStyles.dart';
import '../../../constant/commonWidgets/elevatedButton.dart';
import '../../controller/provider/authProvider.dart';
import '../../widgets/assetGen.dart';
import '../../widgets/orDivider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  String selectedCountryCode = '+91';
  bool loginButtonProgress = false;
  List loginButtonData = [
    [const AssetGen().google.svg(height: 20.sp), 'Google'],
    [const AssetGen().facebook.svg(height: 20.sp), 'Facebook'],
    [const AssetGen().apple.svg(height: 20.sp), 'Apple'],
    [const AssetGen().mail.svg(height: 20.sp), 'Email']
  ];

  login() {
    if (mobileNumberController.text.isNotEmpty) {
      setState(() {
        loginButtonProgress = true;
      });
      context
          .read<MobileAuthProvider>()
          .updateMobileNumber(mobileNumberController.text.trim());
      MobileAuthService.receiveOTP(
          context: context,
          mobileNumber:
              '$selectedCountryCode${mobileNumberController.text.trim()}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your mobile number'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Enter your phone number',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        setState(() {
                          selectedCountryCode = '+${country.phoneCode}';
                        });
                      },
                    );
                  },
                  child: Container(
                    width: 20.w,
                    height: 7.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(
                        color: grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedCountryCode,
                          style: AppTextStyles.textFieldTextStyle,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: black,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 70.w,
                  child: TextFormField(
                    controller: mobileNumberController,
                    cursorColor: black,
                    style: AppTextStyles.textFieldTextStyle,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        // vertical: 0,
                        horizontal: 4.w,
                      ),
                      hintText: 'Mobile number',
                      hintStyle: AppTextStyles.textFieldHintTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(
                          color: grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(
                          color: grey,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(
                          color: grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            ElevatedButtonCommon(
              onPressed: () {
                login();
              },
              backgroundColor: Colors.black,
              height: 6.h,
              width: 94.w,
              child: loginButtonProgress == true
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(white),
                    )
                  : Text('Continue',
                      style: AppTextStyles.small12Bold.copyWith(color: white)),
            ),
            SizedBox(
              height: 2.h,
            ),
            const OrDivider(),
            SizedBox(
              height: 2.h,
            ),
            ListView.builder(
              itemCount: loginButtonData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: 94.w,
                  height: 6.h,
                  margin: EdgeInsets.symmetric(vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: greyShade2,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loginButtonData[index][0],
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        'Continue with ${loginButtonData[index][1]}',
                        style: AppTextStyles.small12Bold,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            const OrDivider(),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                Text('Find my account', style: AppTextStyles.body14),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'By proceeding, you consent to get calls, WhatsApp or SMS messages, including by automated means, from Uber and its affiliates to the number provided.',
              style: AppTextStyles.small10.copyWith(color: grey),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 12.h,
            ),
            RichText(
              text: TextSpan(
                text: 'This site is protected by reCAPTCHA and the Google',
                style: AppTextStyles.small10.copyWith(color: grey),
                children: [
                  TextSpan(
                    text: 'Privacy Policy',
                    style: AppTextStyles.small10.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: '  ',
                    style: AppTextStyles.small10.copyWith(color: grey),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: AppTextStyles.small10.copyWith(color: Colors.green),
                  ),
                  TextSpan(
                    text: ' Terms of Service',
                    style: AppTextStyles.small10.copyWith(color: black),
                  ),
                  TextSpan(
                    text: ' apply.',
                    style: AppTextStyles.small10.copyWith(color: grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
