import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
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
}
