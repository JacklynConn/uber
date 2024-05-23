import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/common/controller/sevices/mobileAuthService.dart';
import 'package:uber/common/widgets/elevatedButtonCommon.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/constant/utils/textStyles.dart';
import 'package:uber/common/controller/provider/authProvider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int num = 60;
  late TextEditingController otpController;
  final _form = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String otp = '';

  decreaseNum() {
    if (num > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          num = num - 1;
        });
        decreaseNum();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      decreaseNum();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButtonCommon(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: white,
                borderRadius: 50.sp,
                height: 6.h,
                width: 6.h,
                child: Icon(
                  Icons.arrow_back,
                  color: black,
                ),
              ),
              SizedBox(width: 2.w),
              ElevatedButtonCommon(
                onPressed: () {
                  MobileAuthService.verifyOTP(
                    context: context,
                    otp: otpController.text.trim(),
                  );
                },
                backgroundColor: white,
                borderRadius: 50.sp,
                height: 6.h,
                width: 6.h,
                child: Row(
                  children: [
                    Text(
                      'Continue',
                      style: AppTextStyles.small12,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            Text(
              'Welcome',
              style: AppTextStyles.body18,
            ),
            SizedBox(height: 2.h),
            Text(
              'Enter the 6-digit code sent to you at ${context.read<MobileAuthProvider>().mobileNumber}',
              style: AppTextStyles.small10,
            ),
            SizedBox(height: 2.h),
            Form(
              key: _form,
              child: PinCodeTextField(
                controller: otpController,
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                obscureText: false,
                animationType: AnimationType.fade,
                textStyle: AppTextStyles.body14,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10.sp),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: white,
                  inactiveColor: greyShade3,
                  inactiveFillColor: greyShade3,
                  selectedFillColor: Colors.white,
                  selectedColor: Colors.black,
                  activeColor: black,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: transparent,
                enableActiveFill: true,
                errorAnimationController: errorController,
                onChanged: (value) {
                  otp = value;
                },
                onCompleted: (value) {
                  MobileAuthService.verifyOTP(
                    context: context,
                    otp: otpController.text.trim(),
                  );
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (num == 0) {
                      num = 60;
                      MobileAuthService.receiveOTP(
                        context: context,
                        mobileNumber:
                            context.read<MobileAuthProvider>().mobileNumber!,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.sp),
                      color: greyShade3,
                    ),
                    child: Text(
                      num > 0
                          ? 'I didn\'t receive a code (00:$num)'
                          : 'I didn\'t receive a code',
                      style: AppTextStyles.small10.copyWith(
                        color: num > 1 ? black38 : black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
