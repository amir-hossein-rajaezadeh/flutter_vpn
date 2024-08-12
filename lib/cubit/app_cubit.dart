import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final config = TextEditingController();
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );
  bool proxyOnly = false;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  final bypassSubnetController = TextEditingController();
  List<String> bypassSubnets = [];
  String? coreVersion;

  String remark = "Default Remark";

  AppCubit()
      : super(
          const AppState(chartValue: 40, vpnIsConnected: false),
        );

  Future<void> getSpeedValue() async {
    emit(
      state.copyWith(chartValue: 11),
    );
    internetSpeedTest();
  }

  Future<void> updateChartValue(double value) async {
    await Future.delayed(
      const Duration(milliseconds: 600),
    );
  }

  void connectVPN() {
    emit(
      state.copyWith(vpnIsConnected: state.vpnIsConnected ? false : true),
    );
  }

  List<double> premiumSpeedList = [34.5, 56.7, 77.3, 71.6];

  Future<void> internetSpeedTest() async {
    for (var element in premiumSpeedList) {
      int doubleValue = Random().nextInt(800) + 1000;
      await Future.delayed(
        Duration(milliseconds: doubleValue),
      ).then((value) {
        emit(
          state.copyWith(
            chartValue: element,
          ),
        );
      });
    }
  }

  bool vpnIsConnected() {
    print(v2rayStatus.value.state);
    return v2rayStatus.value.state == "CONNECTED";
  }

  void connect(BuildContext context) async {
    importConfig(context);
    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(
        remark: remark,
        config: config.text,
        proxyOnly: proxyOnly,
        bypassSubnets: bypassSubnets,
      );
    } else {
      // if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission Denied'),
        ),
      );
      // }
    }
  }

  void importConfig(BuildContext context) async {
    if (await Clipboard.hasStrings()) {
      try {
        
        final V2RayURL v2rayURL = FlutterV2ray.parseFromURL(
            "vless://a05099a9-a33e-43b2-8082-4682b81e5d8f@poe.com:2095?security=none&type=ws&headerType=&path=speedtest.net%3Fed%3D512&host=fg66gh87t65erg76tgb76.greatmp.Ir#%F0%9F%87%B3%F0%9F%87%B1%20Netherland%20%28Hamrah%29");
        remark = v2rayURL.remark;
        config.text = v2rayURL.getFullConfiguration();

        // if (mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text(
        //         'Success',
        //       ),
        //     ),
        //   );
        // }
      } catch (error) {
        // if (mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(
        //         'Error: $error',
        //       ),
        //     ),
        //   );
        // }
      }
    }
  }

  void delay() async {
    // final  int delay;
    // if (v2rayStatus.value.state == 'CONNECTED') {
    //   delay = await flutterV2ray.getConnectedServerDelay();
    // } else {
    //   delay = await flutterV2ray.getServerDelay(config: config.text);
    // }
    // if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       '${delay}ms',
    //     ),
    //   ),
    // );
  }

  void disConnect() {
    flutterV2ray.stopV2Ray();
  }

  void initStateFun() {
    flutterV2ray.initializeV2Ray().then((value) async {
      coreVersion = await flutterV2ray.getCoreVersion();
    });
    print("init Done");
  }
}
