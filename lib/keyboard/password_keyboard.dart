import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/base_keyboard.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/secret.dart';

class PasswordKeyboard extends BaseKeyboard {
  final String points;

  const PasswordKeyboard(
    this.points, {
    super.key,
    super.initDisplay = '비밀번호 (직원 입력)',
    super.displaySize = 55.0,
    super.displayFormat = '',
    super.startZero = true,
    super.displayLimit = 4,
  });

  @override
  BaseKeyboardState createState() => _PasswordKeyboardState();
}

class _PasswordKeyboardState extends BaseKeyboardState {
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
          (amount.startsWith('0'))
              ? amount
              : '${f.format(int.parse(amount))}${widget.suffix}';
      display = display.replaceAll(RegExp(r'\d'), '*');
      style = style.copyWith(color: Colors.black);
    }

    return Expanded(child: Center(child: Text(display, style: style)));
  }

  @override
  disableConfirm() {
    return amount.length != 4;
  }

  @override
  nextPage() {
    PasswordKeyboard subWidget = widget as PasswordKeyboard;

    return (amount == Secret.password)
        ? PageConfig().passwordKeyboard1(subWidget.points)
        : PageConfig().passwordKeyboard2(subWidget.points);
  }
}
