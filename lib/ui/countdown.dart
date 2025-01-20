import 'package:flutter/material.dart';
import 'package:pvpn/values/colors.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  final double size;

  const Countdown({
    super.key,
    required this.seconds,
    required this.size,
  });

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    )..addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: controller.value,
            color: clrCountdownMain,
            backgroundColor: clrCountdownSecondary,
            strokeWidth: widget.size * 0.125,
          ),
          Text((widget.seconds * (1 - controller.value)).ceil().toString(),
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: widget.size * 0.66,
              fontWeight: FontWeight.w600,
              color: clrCountdownMain,
            ),
          ),
        ],
      ),
    );
  }
}