import 'package:reward_points_app/base_keyboard.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';

class UsePointsKeyboard extends BaseKeyboard {
  final Customer customer;

  const UsePointsKeyboard(
    this.customer, {
    super.key,
    super.initDisplay = '0 P',
    super.suffix = ' P',
  });

  @override
  BaseKeyboardState createState() => _UsePointsKeyboardState();
}

class _UsePointsKeyboardState extends BaseKeyboardState {
  @override
  onNumberPress(val) {
    setState(() {
      UsePointsKeyboard subWidget = widget as UsePointsKeyboard;

      if (!widget.startZero && amount.isEmpty && (val == '0' || val == '00')) {
        return;
      }
      if (amount.length + val.length > widget.displayLimit) {
        return;
      }
      if (int.parse(amount + val) > subWidget.customer.points) {
        return;
      }
      amount = amount + val;
    });
  }

  @override
  disableConfirm() {
    return amount.isEmpty || int.parse(amount) < 1000;
  }

  @override
  nextPage() {
    UsePointsKeyboard subWidget = widget as UsePointsKeyboard;

    return PageConfig().usePointsKeyboard(subWidget.customer, amount);
  }

  @override
  confirmButtonText() {
    return '사용';
  }
}
