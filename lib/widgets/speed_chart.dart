import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../cubit/app_cubit.dart';

class SpeedChartWidget extends StatelessWidget {
  const SpeedChartWidget({super.key, required this.initValue});

  final double initValue;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SleekCircularSlider(
      innerWidget: (percentage) {
        context.read<AppCubit>().updateChartValue(percentage);
        return Transform.rotate(
          angle: -3,
          child: Center(
            child: Transform.rotate(
              angle: (percentage * (2.24 / 48)).toDouble(),
              child: SvgPicture.asset(
                "assets/icons/location.svg",
              ),
            ),
          ),
        );
      },
      appearance: CircularSliderAppearance(
        animationEnabled: true,
        animDurationMultiplier: 2.7,
        size: 220,
        customWidths: CustomSliderWidths(
          progressBarWidth: 16,
          trackWidth: 16,
        ),
        customColors: CustomSliderColors(
          dotColor: Colors.white.withOpacity(0.1),
          trackColor: Colors.grey.withOpacity(0.2),
          progressBarColors: [
            const Color.fromRGBO(197, 252, 155, 1),
            const Color.fromRGBO(159, 255, 87, 1),
          ],
        ),
      ),
      min: 0,
      max: 100,
      initialValue: initValue.round().toDouble(),
    );
  }
}
