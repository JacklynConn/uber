import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/constant/utils/colors.dart';

import '../../../constant/utils/textStyles.dart';

class ActivityScreenRider extends StatefulWidget {
  const ActivityScreenRider({super.key});

  @override
  State<ActivityScreenRider> createState() => _ActivityScreenRiderState();
}

class _ActivityScreenRiderState extends State<ActivityScreenRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Uber',
          style: AppTextStyles.heading20Bold,
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 3.w,
        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 1.7.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: index == 9 ? transparent : greyShade3,
                ),
              ),
            ),
            height: 12.6.h,
            width: 90.w,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.w,
                    vertical: 0.5.h,
                  ),
                  height: 9.h,
                  width: 9.h,
                  decoration: BoxDecoration(
                    color: greyShadeButton,
                    borderRadius: BorderRadius.circular(8.sp),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/vehicle/car.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '33, 2nd Cross Road',
                        style: AppTextStyles.small12Bold,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        DateFormat('dd MM, kk:mm a').format(DateTime.now()),
                        style: AppTextStyles.small10.copyWith(
                          color: black87,
                        ),
                      ),
                      Text(
                        '150:00',
                        style: AppTextStyles.small10.copyWith(
                          color: black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
