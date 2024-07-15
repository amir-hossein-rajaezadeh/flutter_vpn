import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vpn/utils/my_colors.dart';
import 'package:flutter_vpn/utils/my_strings.dart';
import 'package:svg_flutter/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter VPN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _switchSlideController;
  late Animation<Offset> _switchAnimation;
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
              Image.asset(
                "assets/images/earth.png",
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 23, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/icons/menu.svg"),
                        Container(
                          height: 40,
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
                padding: const EdgeInsets.only(top: 130),
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
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const Text(
                        "CONNECTED",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(159, 255, 87, 1),
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
                  margin: const EdgeInsets.only(top: 40),
                  width: 132,
                  height: 274,
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
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(
                      top: 20, right: 20, left: 20, bottom: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(159, 255, 87, 1),
                        Color.fromRGBO(
                          195,
                          252,
                          151,
                          1,
                        )
                      ],
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                "assets/icons/canada.png",
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Canada",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child: Text(
                                    "512.122.34.3",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: const Icon(Icons.arrow_outward),
                        )
                      ],
                    ),
                  ),
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
          margin: const EdgeInsets.only(top: 35),
          height: 48,
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
              margin: const EdgeInsets.only(bottom: 8),
              width: 108,
              height: 158,
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
                margin: const EdgeInsets.only(top: 40),
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
                      margin: const EdgeInsets.only(top: 16),
                      width: 60,
                      height: 60,
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
