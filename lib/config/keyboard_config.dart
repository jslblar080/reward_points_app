import 'package:reward_points_app/base_keyboard.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/keyboard/change_points_keyboard.dart';
import 'package:reward_points_app/keyboard/password_keyboard.dart';
import 'package:reward_points_app/keyboard/phone_number_keyboard.dart';
import 'package:reward_points_app/keyboard/review_password_customer_keyboard.dart';
import 'package:reward_points_app/keyboard/review_password_employee_keyboard.dart';
import 'package:reward_points_app/keyboard/review_phone_number_keyboard.dart';
import 'package:reward_points_app/keyboard/use_points_keyboard.dart';

class KeyboardConfig {
  changePointsPage(Customer customer) =>
      ChangePointsKeyboard(initDisplay: 'X,XXX P', customer: customer);

  reviewPasswordEmployeePage(String points, Customer customer) =>
      ReviewPasswordEmployeeKeyboard(points, customer);

  reviewPhoneNumberPage() => ReviewPhoneNumberKeyboard();

  usePointsPage(Customer customer) => UsePointsKeyboard(customer);

  reviewPasswordCustomerPage(String usePoints, Customer customer) =>
      ReviewPasswordCustomerKeyboard(usePoints, customer);

  savePointsPage() => BaseKeyboard(initDisplay: '결제금액', suffix: '원');

  passwordPage(String points) => PasswordKeyboard(points);

  phoneNumberPage(String points) => PhoneNumberKeyboard(points);
}
