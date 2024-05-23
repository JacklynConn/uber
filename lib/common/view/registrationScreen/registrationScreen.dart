import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/constants.dart';
import '/common/widgets/elevatedButtonCommon.dart';
import '/constant/utils/colors.dart';
import '/constant/utils/textStyles.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController =
      TextEditingController(text: '093973138');
  TextEditingController emailController = TextEditingController();
  TextEditingController vehicleModelNameController = TextEditingController();
  TextEditingController vehicleBrandNameController = TextEditingController();
  TextEditingController vehicleRegistrationNumberController =
      TextEditingController();
  TextEditingController driverLicenseNumberController = TextEditingController();

  String selectedVehicleType = 'Select Vehicle Type';
  List<String> vehicleType = [
    'Select Vehicle Type',
    'Mini',
    'Sedan',
    'SUV',
    'Bike',
  ];

  String userType = 'Customer';
  File? profilePic;
  bool registerButtonPressed = false;
  String phoneNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text == auth.currentUser!.phoneNumber!;
    mobileController.text = '+855';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    vehicleBrandNameController.dispose();
    vehicleModelNameController.dispose();
    vehicleRegistrationNumberController.dispose();
    driverLicenseNumberController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 8.h,
                backgroundColor: greyShade3,
                child: Builder(
                  builder: (context) {
                    if (profilePic != null) {
                      return CircleAvatar(
                        radius: (8.h - 2),
                        backgroundColor: white,
                        backgroundImage: FileImage(profilePic!),
                      );
                    } else {
                      return CircleAvatar(
                        radius: (8.h - 2),
                        backgroundColor: white,
                        child: const Image(
                          image: AssetImage(
                            'assets/images/uberLogo/uberLogoBlack.png',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            RegistrationScreenTextField(
              controller: nameController,
              title: 'Name',
              hint: 'Enter your name',
              readOnly: false,
              keyBoardType: TextInputType.name,
            ),
            SizedBox(
              height: 2.h,
            ),
            RegistrationScreenTextField(
              controller: mobileController,
              title: 'Mobile Number',
              hint: 'Enter your mobile number',
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
              readOnly: false,
              keyBoardType: TextInputType.phone,
            ),
            SizedBox(
              height: 2.h,
            ),
            RegistrationScreenTextField(
              controller: emailController,
              title: 'Email',
              hint: 'Enter your email',
              readOnly: false,
              keyBoardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 4.h,
            ),
            selectUserType('Customer'),
            SizedBox(
              height: 2.h,
            ),
            selectUserType('Partner'),
            Builder(builder: (context) {
              if (userType == 'Partner') {
                return partner();
              } else {
                return customer();
              }
            }),
          ],
        ),
      ),
    );
  }

  selectUserType(String updateUserType) {
    return InkWell(
      onTap: () {
        if (registerButtonPressed == false) {
          setState(() {
            userType = updateUserType;
          });
        }
      },
      child: Row(
        children: [
          Container(
            height: 2.5.h,
            width: 2.5.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: userType == updateUserType ? black : transparent,
              borderRadius: BorderRadius.circular(2.sp),
              border: Border.all(
                color: userType == updateUserType ? black : grey,
              ),
            ),
            child: Icon(
              Icons.check,
              color: userType == updateUserType ? white : transparent,
              size: 2.h,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(
            'Continue as $updateUserType',
            style: AppTextStyles.small10.copyWith(
              color: userType == updateUserType ? black : grey,
            ),
          ),
        ],
      ),
    );
  }

  customer() {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        ElevatedButtonCommon(
          onPressed: () {},
          backgroundColor: black,
          height: 6.h,
          width: 94.w,
          child: registerButtonPressed == true
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(white),
                )
              : Text(
                  'Continue',
                  style: AppTextStyles.small12Bold.copyWith(color: white),
                ),
        ),
      ],
    );
  }

  partner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        RegistrationScreenTextField(
          controller: vehicleBrandNameController,
          title: 'Vehicle Brand Name',
          hint: 'Enter your vehicle brand name',
          readOnly: false,
          keyBoardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        RegistrationScreenTextField(
          controller: vehicleModelNameController,
          title: 'Vehicle Model',
          hint: 'Enter your vehicle brand name',
          readOnly: false,
          keyBoardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text('Vehicle Type', style: AppTextStyles.body14Bold),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: grey,
            ),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: DropdownButton(
            isExpanded: true,
            value: selectedVehicleType,
            icon: const Icon(Icons.keyboard_arrow_down),
            underline: const SizedBox(),
            items: vehicleType
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                selectedVehicleType = value!;
              });
            },
          ),
        ),
        RegistrationScreenTextField(
          controller: vehicleRegistrationNumberController,
          title: 'Vehicle Registration Number',
          hint: 'Enter your vehicle registration number',
          readOnly: false,
          keyBoardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        RegistrationScreenTextField(
          controller: driverLicenseNumberController,
          title: 'Driver License No.',
          hint: 'Enter your driver license number',
          readOnly: false,
          keyBoardType: TextInputType.name,
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          height: 10.h,
        ),
        ElevatedButtonCommon(
          onPressed: () {
            if (registerButtonPressed == false) {
              setState(() {
                registerButtonPressed = true;
              });
            }
          },
          backgroundColor: black,
          height: 6.h,
          width: 94.w,
          child: registerButtonPressed == true
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(white),
                )
              : Text(
                  'Continue',
                  style: AppTextStyles.small12Bold.copyWith(color: white),
                ),
        ),
      ],
    );
  }
}

class RegistrationScreenTextField extends StatefulWidget {
  const RegistrationScreenTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.readOnly,
    required this.keyBoardType,
    this.onChanged,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final bool readOnly;
  final TextInputType keyBoardType;
  final Function(String)? onChanged;

  @override
  State<RegistrationScreenTextField> createState() =>
      _RegistrationScreenTextFieldState();
}

class _RegistrationScreenTextFieldState
    extends State<RegistrationScreenTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        Text(
          widget.title,
          style: AppTextStyles.body14Bold,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextFormField(
          controller: widget.controller,
          cursorColor: black,
          style: AppTextStyles.textFieldTextStyle,
          keyboardType: widget.keyBoardType,
          readOnly: widget.readOnly,
          onChanged: (value) {
            setState(() {
              widget.controller.text = value;
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2.w,
              vertical: 0,
            ),
            hintText: widget.hint,
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
                color: black,
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
      ],
    );
  }
}
