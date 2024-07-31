part of 'app_cubit.dart';

class AppState extends Equatable {
  final double chartValue;
  const AppState({ required this.chartValue});

  AppState copyWith({int? speedValue, double? chartValue}) {
    return AppState(
        chartValue: chartValue ?? this.chartValue);
  }

  @override
  List<Object> get props => [chartValue];
}
