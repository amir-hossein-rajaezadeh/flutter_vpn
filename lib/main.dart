import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vpn/utils/my_colors.dart';
import 'package:flutter_vpn/utils/my_strings.dart';
import 'package:svg_flutter/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

enum UploadDownloadEnum { download, upload }

enum SpeedTypeEnum { mb, kb }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset("assets/images/earth.svg"),
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
                        Container(
                          child: SvgPicture.asset("assets/icons/menu.svg"),
                        ),
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
                padding: const EdgeInsets.only(top: 150),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: _buildUploadDownloadSpeed("124.1",
                                SpeedTypeEnum.mb, UploadDownloadEnum.download),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            child: _buildUploadDownloadSpeed("236.4",
                                SpeedTypeEnum.kb, UploadDownloadEnum.upload),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
            child: Column(
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
                Container(
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
                              colors: [
                                Colors.black.withOpacity(0.88),
                                Colors.grey
                              ],
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadDownloadSpeed(
      String speed, SpeedTypeEnum speedType, UploadDownloadEnum status) {
    return Row(
      children: [
        RotatedBox(
          quarterTurns: status.name == "download" ? 3 : 1,
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
                text: speedType.name == "mb" ? " Mb/s" : " Kb/s",
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
