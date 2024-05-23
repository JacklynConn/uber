import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/constant/utils/textStyles.dart';

class AccountScreenRider extends StatefulWidget {
  const AccountScreenRider({super.key});

  @override
  State<AccountScreenRider> createState() => _AccountScreenRiderState();
}

class _AccountScreenRiderState extends State<AccountScreenRider> {
  @override
  Widget build(BuildContext context) {
    List accountTopButton = [
      [CupertinoIcons.shield_fill, 'Help'],
      [CupertinoIcons.creditcard_fill, 'Payment'],
      [CupertinoIcons.square_list_fill, 'Activity'],
    ];
    List accountButtons = [
      [
        CupertinoIcons.gift_fill,
        'Send a Gift',
      ],
      [
        CupertinoIcons.gear_alt_fill,
        'Settings',
      ],
      [
        CupertinoIcons.envelope_fill,
        'Messages',
      ],
      [
        CupertinoIcons.money_dollar_circle_fill,
        'Earn by driving or delivering',
      ],
      [
        CupertinoIcons.briefcase_fill,
        'Business hub',
      ],
      [
        CupertinoIcons.person_2_fill,
        'Refer friends, unlock deals',
      ],
      [
        CupertinoIcons.person_fill,
        'Manage Uber account',
      ],
      [
        CupertinoIcons.power,
        'Logout',
      ],
    ];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Top Row
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              children: [
                // Profile Data
                Row(
                  children: [
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        'Mak Machksp',
                        style: AppTextStyles.heading26Bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 16.w,
                      width: 16.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: black87,
                        ),
                        color: Colors.black87,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/uberLogo/uber.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                // Top Row Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: accountTopButton
                      .map((e) => Container(
                            width: 28.w,
                            height: 10.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: greyShade3,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  e[0],
                                  color: black87,
                                  size: 4.h,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  e[1],
                                  style: AppTextStyles.small10,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              color: greyShade2,
              thickness: 0.5.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: accountButtons.length,
              itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      accountButtons[index][0],
                      color: black,
                      size: 3.h,
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Text(
                      accountButtons[index][1],
                      style: AppTextStyles.small12,
                    ),
                  ],
                ),
              );
            },)
          ],
        ),
      ),
    );
  }
}
