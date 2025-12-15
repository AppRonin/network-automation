import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class SimpleProgressBar extends StatelessWidget {
  final double progress;

  const SimpleProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final percentText = "${(progress * 100).round()}%";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        LinearPercentIndicator(
          lineHeight: 12,
          percent: progress.clamp(0.0, 1.0),
          barRadius: const Radius.circular(8),
          backgroundColor: Colors.grey.shade300,
          progressColor: Colors.black,
          animation: true,
          animationDuration: 800,
        ),
        SizedBox(height: 8),
        Text(
          percentText,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
