import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/utils/colors.dart';
import '../../../constant/utils/textStyles.dart';

class ServiceScreenRider extends StatefulWidget {
  const ServiceScreenRider({super.key});

  @override
  State<ServiceScreenRider> createState() => _ServiceScreenRiderState();
}

class _ServiceScreenRiderState extends State<ServiceScreenRider> {
  @override
  Widget build(BuildContext context) {
    List firstRow = [
      [
        'assets/images/services/trip.png',
        'Trip',
      ],
      [
        'assets/images/services/rentals.png',
        'Rentals',
      ],
    ];

    List secondRow = [
      [
        'assets/images/services/reserve.png',
        'Reserve',
      ],
      [
        'assets/images/services/intercity.png',
        'Intercity',
      ],
      [
        'assets/images/services/groupRide.png',
        'Group Ride',
      ],
      [
        'assets/images/services/package.png',
        'Package',
      ]
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services',
          style: AppTextStyles.heading20Bold,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        children: [
          SizedBox(height: 1.h),
          Text('Go anywhere, get anything', style: AppTextStyles.body14Bold),
          SizedBox(height: 2.h),
          // First Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: firstRow
                .map(
                  (e) => Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    width: 44.w,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(8.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          // blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e[1],
                          style: AppTextStyles.small12,
                        ),
                        SizedBox(
                          height: 8.h,
                          width: 8.h,
                          child: Image.asset(
                            e[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 2.h),
          // Second Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: secondRow
                .map(
                  (e) => Column(
                    children: [
                      Container(
                        width: 20.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: greyShadeButton,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: SizedBox(
                          height: 8.h,
                          width: 8.h,
                          child: Image.asset(
                            e[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        e[1],
                        style: AppTextStyles.small12,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
