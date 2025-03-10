import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/base_keyboard.dart';
import 'package:reward_points_app/config/page_config.dart';

class PhoneNumberKeyboard extends BaseKeyboard {
  final String points;

  const PhoneNumberKeyboard(
    this.points, {
    super.key,
    super.initDisplay = '010-',
    super.displaySize = 55.0,
    super.displayFormat = '',
    super.startZero = true,
    super.displayLimit = 8,
  });

  @override
  BaseKeyboardState createState() => _PhoneNumberKeyboardState();
}

class _PhoneNumberKeyboardState extends BaseKeyboardState {
  @override
  renderText() {
    String display = widget.initDisplay;
    TextStyle style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: widget.displaySize,
    );

    if (amount.isNotEmpty) {
      NumberFormat f = NumberFormat(widget.displayFormat);

      display =
          widget.initDisplay +
          ((amount.startsWith('0'))
              ? amount
              : '${f.format(int.parse(amount))}${widget.suffix}');
      if (amount.length >= 4) {
        display = '${display.substring(0, 8)}-${amount.substring(4)}';
      }
      style = style.copyWith(color: Colors.black);
    }

    return Expanded(child: Center(child: Text(display, style: style)));
  }

  @override
  disableConfirm() {
    return amount.length != 8;
  }

  @override
  nextPage() {
    PhoneNumberKeyboard subWidget = widget as PhoneNumberKeyboard;

    return PageConfig().phoneNumberKeyboard(subWidget.points, amount);
  }
}
