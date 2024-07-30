import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn/widgets/country_item.dart';
import 'package:svg_flutter/svg.dart';
import '../model/country_model.dart';
import '../utils/my_colors.dart';
import '../utils/my_strings.dart';
import '../widgets/custom_btn.dart';
import 'speed_test_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _switchSlideController;
  late Animation<Offset> _switchAnimation;
  final List<CountryModel> countryList = [
    CountryModel(
        countryName: "USA",
        countryImage: "assets/images/usa.png",
        countryIp: "420.115.40.80"),
    CountryModel(
        countryName: "France",
        countryImage: "assets/images/france.png",
        countryIp: "356.803.24.46"),
    CountryModel(
        countryName: "Spanish",
        countryImage: "assets/images/spanish.png",
        countryIp: "401.506.65.72"),
    CountryModel(
        countryName: "Italian",
        countryImage: "assets/images/italien.png",
        countryIp: "416.412.80.56"),
  ];

  @override
  void initState() {
    _switchSlideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _switchAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.6),
    ).animate(_switchSlideController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 450.w,
                height: 365.h,
                child:
                    Image.asset("assets/images/earth.png", fit: BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.only(top: 60.h),
                child: SizedBox(
                  height: 40.h,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 23, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/icons/menu.svg"),
                        Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: MyColors.primaryGreen),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/crown.svg"),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Text(
                                  MyStrings.premium,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "02:15",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: const Text(
                        "CONNECTED",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(159, 255, 87, 1),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22.h),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SpeedTestPage();
                          },
                        )),
                        child: const Text(
                          "Test Speed",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.yellow),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: _buildUploadDownloadSpeed(
                              "124.1", "Mb/s", "download"),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: _buildUploadDownloadSpeed(
                              "236.4", "Kb/s", "upload"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60.h),
                  width: 132,
                  height: 274.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.16),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: _buildToggleBtn(),
                ),
                const Spacer(),
                buildCustomBtnWidget("Canada", "assets/icons/canada.svg", true,
                    () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(26),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      backgroundColor: MyColors.darkBackground,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          color: MyColors.darkBackground,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: const Icon(
                                  Icons.keyboard_arrow_up_sharp,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 14, left: 16),
                                  child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: countryList.length,
                                    itemBuilder: (context, index) {
                                      return buildCountryItem(
                                          countryList[index]);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 34,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
                SizedBox(
                  height: 22.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildToggleBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 35.h),
          height: 48.h,
          width: 32,
          child: SvgPicture.asset(
            "assets/icons/arrow_up.svg",
            fit: BoxFit.cover,
          ),
        ),
        SlideTransition(
          position: _switchAnimation,
          child: GestureDetector(
            onTap: () {
              if (_switchAnimation.value == Offset.zero) {
                _switchSlideController.forward();
              } else {
                _switchSlideController.reverse();
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8.h),
              width: 108,
              height: 158.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  transform: GradientRotation(9.87),
                  stops: [0.1, 1],
                  colors: [
                    Color.fromRGBO(178, 181, 54, 1),
                    Color.fromRGBO(126, 177, 88, 1),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Column(
                  children: [
                    const Text(
                      MyStrings.stop,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      width: 56,
                      height: 60.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          stops: const [0, 1],
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withOpacity(0.88), Colors.grey],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.white.withOpacity(0.6),
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadDownloadSpeed(
      String speed, String speedType, String status) {
    return Row(
      children: [
        RotatedBox(
          quarterTurns: status == "download" ? 3 : 1,
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text.rich(
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
          TextSpan(
            text: speed,
            children: <InlineSpan>[
              TextSpan(
                text: speedType,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
