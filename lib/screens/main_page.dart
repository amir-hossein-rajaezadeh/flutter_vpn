import 'dart:async';
import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn/cubit/app_cubit.dart';
import 'package:flutter_vpn/utils/speed_seprator.dart';
import 'package:flutter_vpn/widgets/country_item.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg.dart';
import '../model/country_model.dart';
import '../utils/my_colors.dart';
import '../utils/my_strings.dart';
import '../widgets/custom_btn.dart';

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
        countryName: "Canada",
        countryImage: "assets/images/canada.png",
        countryIp: "420.115.40.80"),
    CountryModel(
        countryName: "USA",
        countryImage: "assets/images/usa.png",
        countryIp: "420.115.40.80"),
    CountryModel(
        countryName: "France",
        countryImage: "assets/images/france.png",
        countryIp: "356.803.24.46"),
    CountryModel(
        countryName: "Spain",
        countryImage: "assets/images/spanish.png",
        countryIp: "401.506.65.72"),
    CountryModel(
        countryName: "Italy",
        countryImage: "assets/images/italien.png",
        countryIp: "416.412.80.56"),
  ];
  String currentTime = "";

  @override
  void initState() {
    context.read<AppCubit>().initStateFun();

    _switchSlideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _switchAnimation = Tween<Offset>(
      begin: Offset(
          0.0,
          context.read<AppCubit>().v2rayStatus.value.state == "CONNECTED"
              ? -0.6
              : 0.0),
      end: Offset(0.0, context.read<AppCubit>().vpnIsConnected() ? 0.0 : -0.6),
    ).animate(_switchSlideController);
    Timer.periodic(
      const Duration(seconds: 2),
      (Timer t) {
        setState(() {
          currentTime = DateFormat('hh:mm').format(DateTime.now());
        });
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    context.read<AppCubit>().config.dispose();
    context.read<AppCubit>().bypassSubnetController.dispose();
    super.dispose();
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
                margin: const EdgeInsets.only(top: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.lightGreen,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 2),
                      child: Image.asset("assets/images/line.png"),
                    ),
                  ],
                ),
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
                                Image.asset(
                                  "assets/icons/crown.png",
                                  alignment: Alignment.center,
                                ),
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
              BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(top: 120.h),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          currentTime,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          context.read<AppCubit>().v2rayStatus.value.state,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(159, 255, 87, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 22.h),
                        child: GestureDetector(
                          onTap: () =>
                              context.read<AppCubit>().importConfig(context),
                          //   Navigator.push(context, MaterialPageRoute(
                          // builder: (context) {
                          //   return const SpeedTestPage();
                          // },
                          // )),
                          child: const Text(
                            "Test Speed",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.yellow),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: context.read<AppCubit>().v2rayStatus,
                          builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: _buildUploadDownloadSpeed(
                                      vpnSpeed(value.downloadSpeed),
                                      vpnType(value.downloadSpeed),
                                      "download",
                                      state),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  child: _buildUploadDownloadSpeed(
                                      vpnSpeed(value.uploadSpeed),
                                      vpnType(value.uploadSpeed),
                                      "upload",
                                      state),
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                );
              })
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
                  child: Column(
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
                      BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          return _buildToggleButton(context, state);
                        },
                      )
                    ],
                  ),
                ),
                const Spacer(),
                buildCustomBtnWidget("Canada", "assets/images/canada.png", true,
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
                          height: MediaQuery.of(context).size.height * 0.42,
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
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: countryList.length,
                                    padding: const EdgeInsets.only(top: 0),
                                    itemBuilder: (context, index) {
                                      return buildCountryItem(
                                          countryList[index], index);
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

  Widget _buildToggleButton(BuildContext context, AppState state) {
    return SlideTransition(
      position: _switchAnimation,
      child: GestureDetector(
        onTap: () async {
          if (!context.read<AppCubit>().vpnIsConnected()) {
            context.read<AppCubit>().connect(context);
            if (!context.read<AppCubit>().vpnIsConnected()) {
              await Future.delayed(const Duration(milliseconds: 600));
              _switchSlideController.forward();
            } else {
              _switchSlideController.reverse();
            }
          } else {
            context.read<AppCubit>().disConnect();
            if (context.read<AppCubit>().vpnIsConnected()) {
              _switchSlideController.reverse();
            } else {
              _switchSlideController.forward();
            }
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
                Text(
                  context.read<AppCubit>().vpnIsConnected()
                      ? MyStrings.stop
                      : MyStrings.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(top: 12.h),
                  width: 56,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        stops: const [0, 1],
                        end: Alignment.bottomCenter,
                        colors: context.read<AppCubit>().vpnIsConnected()
                            ? MyColors.connectedButtonColorList
                            : MyColors.disConnectedButtonColorList),
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
    );
  }

  Widget _buildUploadDownloadSpeed(
      String speed, String speedType, String status, AppState state) {
    return Row(
      children: [
        RotatedBox(
          quarterTurns: status == "download" ? 3 : 1,
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          children: [
            AnimatedDigitWidget(
              value: double.parse(speed),
              fractionDigits: 1,
              duration: const Duration(milliseconds: 1300),
              textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 1),
              child: Text(
                speedType,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
