import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vpn/cubit/app_cubit.dart';
import 'package:flutter_vpn/screens/premium_page.dart';
import 'package:flutter_vpn/utils/my_strings.dart';
import 'package:flutter_vpn/widgets/app_bar_widget.dart';
import 'package:flutter_vpn/widgets/speed_chart.dart';
import 'package:svg_flutter/svg.dart';
import '../widgets/custom_btn.dart';

class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({super.key});

  @override
  State<SpeedTestPage> createState() => _SpeedTestPageState();
}

class _SpeedTestPageState extends State<SpeedTestPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    initFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: buildAppBarWidget("Speed Test", Colors.white, context),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildServiceSpeedWidget("10.55", true),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      width: 1,
                      height: 18,
                      color: Colors.grey,
                    ),
                    buildServiceSpeedWidget("6.30", false),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: SpeedChartWidget(
                    initValue: state.speedValue.toDouble(),
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "60.3",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF9FFF57),
                          fontWeight: FontWeight.w700,
                          height: 1),
                    ),
                    Text(
                      "Mbs",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(right: 24, left: 24),
                height: 210,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/earth2.png",
                  fit: BoxFit.cover,
                ),
              ),
              buildCustomBtnWidget(
                  MyStrings.premium, "assets/icons/crown.svg", false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const PremiumPage();
                    },
                  ),
                );
              })
            ],
          );
        },
      ),
    );
  }

  Row buildServiceSpeedWidget(String speed, bool isUpload) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 6),
          child: SvgPicture.asset(
              isUpload ? "assets/icons/export.svg" : "assets/icons/import.svg"),
        ),
        const Text.rich(
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          TextSpan(
            text: "10.55",
            children: <InlineSpan>[
              TextSpan(
                text: "Mbs",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> initFun() async {
    context.read<AppCubit>().getSpeedValue();

    Timer.periodic(const Duration(milliseconds: 1200), (timer) {});
  }
}
