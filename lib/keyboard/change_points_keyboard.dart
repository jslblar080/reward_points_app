import 'package:reward_points_app/base_keyboard.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';

class ChangePointsKeyboard extends BaseKeyboard {
  final Customer customer;

  const ChangePointsKeyboard({
    super.key,
    required super.initDisplay,
    super.suffix = ' P',
    required this.customer,
  });

  @override
  BaseKeyboardState createState() => _ChangePointsKeyboardState();
}

class _ChangePointsKeyboardState extends BaseKeyboardState {
  @override
  nextPage() {
    ChangePointsKeyboard subWidget = widget as ChangePointsKeyboard;

    return PageConfig().changePointsKeyboard(amount, subWidget.customer);
  }
}
