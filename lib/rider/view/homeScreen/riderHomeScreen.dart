import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/constant/utils/textStyles.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  List suggestions = [
    ['assets/images/suggestions/trip.png', 'Trip'],
    ['assets/images/suggestions/rentals.png', 'Rentals'],
    ['assets/images/suggestions/reserve.png', 'Reserve'],
    ['assets/images/suggestions/intercity.png', 'Intercity'],
  ];
  List moreWaysToUseUber = [
    [
      'assets/images/moreWaysUber/sendAPackage.png',
      'Send a package',
      'On-demand delivery across town',
    ],
    [
      'assets/images/moreWaysUber/premierTrips.png',
      'Premier trips',
      'Top-rated drivers, newer cars',
    ],
    [
      'assets/images/moreWaysUber/safetyToolKit.png',
      'Safety toolkit',
      'On-trip help with safety issues',
    ],
  ];
  List planYourNextTrip = [
    [
      'assets/images/planNextTrip/travelIntercity.png',
      'Travel Intercity',
      'Get to remote locations with ease',
    ],
    [
      'assets/images/planNextTrip/rentals.png',
      'Rentals',
      'Travel from 1 to 12 hours',
    ],
  ];

  List saveEveryDay = [
    [
      'assets/images/saveEveryDay/tryAGroupTrip.png',
      'Uber Moto trips',
      'Affordable, motorcycle pick-ups',
    ],
    [
      'assets/images/saveEveryDay/uberMotoTrips.png',
      'Try a group trip',
      'Seamless, trips, together',
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Uber',
          style: AppTextStyles.heading20Bold,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Where To Button
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: greyShade3,
                borderRadius: BorderRadius.circular(50.sp),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Where to?',
                      style: AppTextStyles.body16.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Previous Trips Records
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 0.5.h),
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 3.h,
                      backgroundColor: greyShade3,
                      child: Icon(
                        Icons.location_on,
                        color: black,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Main Address',
                            style: AppTextStyles.body14Bold,
                          ),
                          Text(
                            'Main Address Description',
                            style: AppTextStyles.small10
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: greyShade3,
                      size: 15.sp,
                    ),
                  ],
                ),
              );
            },
          ),
          // Suggestions
          SizedBox(
            height: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suggestions',
                    style: AppTextStyles.heading20Bold,
                  ),
                  Text(
                    'See All',
                    style: AppTextStyles.small10.copyWith(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: suggestions
                    .map(
                      (e) => SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 15.w,
                              width: 20.w,
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                color: greyShadeButton,
                              ),
                              child: Image.asset(
                                e[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              e[1],
                              style: AppTextStyles.small10Bold.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              //   Banner
              SizedBox(height: 2.h),
              const Image(
                image: AssetImage(
                  'assets/images/promotion/promo.png',
                ),
              ),
              SizedBox(height: 3.h),
              ExploreFeaturesHorizontalListView(
                title: 'More ways to use Uber',
                list: moreWaysToUseUber,
              ),
              SizedBox(height: 4.h),
              ExploreFeaturesHorizontalListView(
                title: 'Plan your next trip',
                list: planYourNextTrip,
              ),
              SizedBox(height: 4.h),
              ExploreFeaturesHorizontalListView(
                title: 'Save every day',
                list: saveEveryDay,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExploreFeaturesHorizontalListView extends StatelessWidget {
  const ExploreFeaturesHorizontalListView({
    super.key,
    required this.list,
    required this.title,
  });

  final List list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.body14Bold,
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 24.h,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : 1.5.w,
                  right: index == (list.length - 1) ? 0 : 1.5.w,
                ),
                height: 18.h,
                width: 65.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18.h,
                      width: 65.w,
                      decoration: BoxDecoration(
                        color: greyShadeButton,
                        borderRadius: BorderRadius.circular(8.sp),
                        image: DecorationImage(
                          image: AssetImage(
                            list[index][0],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          list[index][1],
                          style: AppTextStyles.small12Bold,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black87,
                          size: 2.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 0.2.h),
                    Text(
                      list[index][2],
                      style: AppTextStyles.small10.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
