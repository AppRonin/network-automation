import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class SimpleProgressBar extends StatelessWidget {
  final double progress; // 0..100

  const SimpleProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 4),

        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: (progress / 100).clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return LinearPercentIndicator(
              lineHeight: 12,
              percent: value,
              barRadius: const Radius.circular(8),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.black,
              animation: false, // IMPORTANT
            );
          },
        ),

        const SizedBox(height: 8),

        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return Text(
              "${value.round()}%",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            );
          },
        ),
      ],
    );
  }
}
