import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn/utils/my_strings.dart';
import 'package:flutter_vpn/widgets/app_bar_widget.dart';
import 'package:flutter_vpn/widgets/custom_btn.dart';
import 'package:flutter_vpn/widgets/speed_chart.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> vpnPremiumList = [
      "Increase speed",
      "Open all services",
      "Full time support"
    ];
    List<String> vpnFreeList = ["The opening of six services"];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.h),
                width: 667.w,
                height: 365.h,
                child: Image.asset(
                  "assets/images/earth.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 45),
                child: Column(
                  children: [
                    buildAppBarWidget(
                        MyStrings.premium, const Color(0xFF9FFF57), context),
                    Container(
                      margin:
                          const EdgeInsets.only(right: 22, left: 22, top: 42),
                      child: const Text(
                        "Experience the best speed with a premium account",
                        style: TextStyle(
                            color: Color(0xFF9FFF57),
                            fontSize: 38,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 42.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildServiceOptionsWidget("Free", vpnFreeList),
                          SizedBox(width: 26.w),
                          _buildServiceOptionsWidget("Premium", vpnPremiumList),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: SpeedChartWidget(initValue: 100),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20),
                child: const Text(
                  "\$8/mo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF9FFF57),
                  ),
                ),
              ),
              Expanded(
                child: buildCustomBtnWidget(
                  "Get started today",
                  "",
                  false,
                  () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  Container _buildServiceOptionsWidget(String title, List<String> itemList) {
    int itemLength = itemList.length;
    return Container(
      width: 175.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF9FFF57),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 24, bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "VPN\n$title",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9FFF57),
              ),
            ),
            _buildItemPointsWidget(
                itemList, (itemLength) * (itemLength == 1 ? 65 : 41))
          ],
        ),
      ),
    );
  }

  SizedBox _buildItemPointsWidget(List<String> itemList, double listHeight) {
    return SizedBox(
      height: listHeight.h,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0),
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final String itemTitle = itemList[index];
          return Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  width: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9FFF57),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: 8,
                ),
                Expanded(
                  child: Text(
                    itemTitle,
                    style: const TextStyle(
                      color: Color(0xFF9FFF57),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
