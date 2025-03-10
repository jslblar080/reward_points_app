import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/base_keyboard.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/secret.dart';

class ReviewPasswordEmployeeKeyboard extends BaseKeyboard {
  final String points;
  final Customer customer;

  const ReviewPasswordEmployeeKeyboard(
    this.points,
    this.customer, {
    super.key,
    super.initDisplay = '비밀번호 (직원 입력)',
    super.displaySize = 55.0,
    super.displayFormat = '',
    super.startZero = true,
    super.displayLimit = 4,
  });

  @override
  BaseKeyboardState createState() => _ReviewPasswordEmployeeKeyboardState();
}

class _ReviewPasswordEmployeeKeyboardState extends BaseKeyboardState {
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
    ReviewPasswordEmployeeKeyboard subWidget =
        widget as ReviewPasswordEmployeeKeyboard;

    return (amount == Secret.password)
        ? PageConfig().reviewPasswordEmployeeKeyboard1(
          subWidget.points,
          subWidget.customer,
        )
        : PageConfig().reviewPasswordEmployeeKeyboard2(
          subWidget.points,
          subWidget.customer,
        );
  }
}
