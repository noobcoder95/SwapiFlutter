import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final double? height, width;
  final TextStyle? textStyle;

  const CustomBadge({
    super.key,
    required this.label,
    this.textStyle,
    this.height,
    this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      padding: const EdgeInsets.all(10),
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      child: Text(
        label,
        style: textStyle,
      ),
    );
  }
}