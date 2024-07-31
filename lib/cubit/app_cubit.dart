import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState( chartValue: 40),
        );

  Future<void> getSpeedValue() async {
    emit(
      state.copyWith(chartValue: 11),
    );
    internetSpeedTest();

    // emit(
    //   state.copyWith(speedValue: 70),
    // );
  }

  Future<void> updateChartValue(double value) async {
    await Future.delayed(
      const Duration(milliseconds: 600),
    );
    // emit(
    //   state.copyWith(
    //     chartValue: value * (2.25 / 48),
    //   ),
    // );
  }

  List<double> premiumSpeedList = [34.5, 56.7, 67.8, 77.3, 71.6];

  Future<void> internetSpeedTest() async {
    for (var element in premiumSpeedList) {
      var doubleValue = Random().nextInt(800) + 1000;

      await Future.delayed(
        Duration(milliseconds: doubleValue),
      ).then((value) {
        emit(
          state.copyWith(
            chartValue: element,
          ),
        );
        print("element is ${state.chartValue}   e $element");
      });
    }
  }
}
