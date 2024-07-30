import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(speedValue: 40, chartValue: 40),
        );

  Future<void> getSpeedValue() async {
    emit(
      state.copyWith(speedValue: 70),
    );
  }

  void updateChartValue(double value) {
    emit(
      state.copyWith(
        chartValue: value * (2.25 / 48),
      ),
    );
  }
}
