import 'package:flutter/material.dart';

class ModeTitle extends StatelessWidget {
  late final Icon icon;
  late final String title;

  ModeTitle({required this.icon, required this.title});
  final MainAxisAlignment alignment = MainAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        icon,
        Container(width: 5),
        Text(title),
      ],
    );
  }
}