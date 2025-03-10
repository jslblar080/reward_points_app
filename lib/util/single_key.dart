import 'package:flutter/material.dart';

class SingleKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const SingleKey({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<SingleKey> createState() => _SingleKeyState();
}

class _SingleKeyState extends State<SingleKey> {
  renderLabel() {
    if (widget.label is Widget) {
      return widget.label;
    }

    return Text(
      widget.label,
      style: const TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.grey),
        ),
        width: 120,
        height: 80,
        child: AspectRatio(
          aspectRatio: 1.5, // width / height
          child: Center(child: renderLabel()),
        ),
      ),
    );
  }
}
