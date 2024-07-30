part of 'app_cubit.dart';

class AppState extends Equatable {
  final int speedValue;
final double chartValue;
  const AppState({required this.speedValue,required this.chartValue});

  AppState copyWith({int? speedValue,double? chartValue}) {
    return AppState(speedValue: speedValue ?? this.speedValue, chartValue: chartValue??this.chartValue);
  }

  @override
  List<Object> get props => [speedValue,chartValue];
}
