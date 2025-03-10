import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String data;
  final Color color;
  final double fontsize;
  final double? height;

  const StyledText({
    super.key,
    required this.data,
    required this.color,
    this.fontsize = 100.0,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(color: color, fontSize: fontsize, height: height),
    );
  }
}
