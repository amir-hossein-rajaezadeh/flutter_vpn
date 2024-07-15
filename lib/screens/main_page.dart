import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import '../utils/my_strings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _dayAndNightPhotoController;
  late Animation<Offset> _dayNightPhotoAndVerticalSwitchAnimation;
  @override
  void initState() {
    _dayAndNightPhotoController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();

    _dayNightPhotoAndVerticalSwitchAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.6),
    ).animate(_dayAndNightPhotoController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Container(
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
                SlideTransition(
                  position: _dayNightPhotoAndVerticalSwitchAnimation,
                  child: _buildToggleBtn(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _buildToggleBtn() {
    return Container(
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
    );
  }
}
