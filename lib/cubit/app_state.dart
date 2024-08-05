part of 'app_cubit.dart';

class AppState extends Equatable {
  final double chartValue;
  final bool vpnIsConnected;
  const AppState({ required this.chartValue,required this.vpnIsConnected});

  AppState copyWith({bool? vpnIsConnected, double? chartValue}) {
    return AppState(
        chartValue: chartValue ?? this.chartValue,
        vpnIsConnected: vpnIsConnected??this.vpnIsConnected
        );
  }

  @override
  List<Object> get props => [chartValue,vpnIsConnected];
}
