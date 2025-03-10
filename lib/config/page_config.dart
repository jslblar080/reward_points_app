import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/page/home_page.dart';
import 'package:reward_points_app/page/review/customer/review_password_customer_page.dart';
import 'package:reward_points_app/page/review/customer/review_phone_number_page.dart';
import 'package:reward_points_app/page/review/customer/use_points_page.dart';
import 'package:reward_points_app/page/review/customer/use_success_page.dart';
import 'package:reward_points_app/page/review/employee/change_points_page.dart';
import 'package:reward_points_app/page/review/employee/change_success_page.dart';
import 'package:reward_points_app/page/review/employee/reivew_password_employee_page.dart';
import 'package:reward_points_app/page/review/employee/review_customers_page.dart';
import 'package:reward_points_app/page/save/password_page.dart';
import 'package:reward_points_app/page/save/phone_number_page.dart';
import 'package:reward_points_app/page/review/review_points_page.dart';
import 'package:reward_points_app/page/save/save_points_page.dart';
import 'package:reward_points_app/page/save/save_success_page.dart';

class PageConfig {
  main() => HomePage();

  // 직원에게 요청을 해주세요.
  homePage1() => ReviewPointsPage(); // 사용/조회

  // 버튼을 선택해주세요.
  reviewPointsPage1() => HomePage(); // 취소 X

  // 버튼을 선택해주세요.
  reviewPointsPage2() => ReviewCustomersPage(); // 직원용

  // 고객 목록
  customerCard(Customer customer) =>
      ChangePointsPage(customer); // 날짜 별 조회 / 보유 포인트 수정 -> 포인트 내역: 보유 포인트 수정

  // 보유 포인트를 수정해주세요.
  changePointsPage() => HomePage(); // 취소 X
  changePointsKeyboard(String points, Customer customer) =>
      ReivewPasswordEmployeePage(points: points, customer: customer); // 확인

  // 비밀번호 (직원 입력)
  reviewPasswordEmployeePage() => HomePage(); // 취소 X
  reviewPasswordEmployeeKeyboard1(String points, Customer customer) =>
      ChangeSuccessPage(points: points, customer: customer); // 확인
  reviewPasswordEmployeeKeyboard2(String points, Customer customer) =>
      ReivewPasswordEmployeePage(points: points, customer: customer); // 다시 입력하기

  // 정보 입력을 완료했습니다.
  changeSuccessPage() => HomePage(); // 나가기 X

  // 버튼을 선택해주세요.
  reviewPointsPage3() => ReviewPhoneNumberPage(); // 고객용

  // 휴대전화번호를 눌러주세요.
  reviewPhoneNumberPage() => HomePage(); // 취소 X
  reviewPhoneNumberKeyboard(String phoneNumber) =>
      UsePointsPage(phoneNumber); // 확인

  // 사용할 포인트를 입력하세요.
  usePointsPage() => HomePage(); // 취소 X
  usePointsKeyboard(Customer customer, String usePoints) =>
      ReviewPasswordCustomerPage(
        customer: customer,
        usePoints: usePoints,
      ); // 사용

  // 비밀번호 (직원 입력)
  reviewPasswordCustomerPage() => HomePage(); // 취소
  reviewPasswordCustomerKeyboard1(String usePoints, Customer customer) =>
      UseSuccessPage(usePoints: usePoints, customer: customer); // 확인
  reviewPasswordCustomerKeyboard2(String usePoints, Customer customer) =>
      ReviewPasswordCustomerPage(
        usePoints: usePoints,
        customer: customer,
      ); // 다시 입력하기

  // 정보 입력을 완료했습니다.
  useSuccessPage() => HomePage(); // 나가기 X

  // 직원에게 요청을 해주세요.
  homePage2() => SavePointsPage(); // 포인트 적립

  // 금액을 입력해주세요.
  savePointsPage() => HomePage(); // 취소 X
  baseKeyboard(String points) => PasswordPage(points: points); // 확인

  // 비밀번호 (직원 입력)
  passwordPage() => SavePointsPage(); // 뒤로가기
  passwordKeyboard1(String points) => PhoneNumberPage(points: points); // 확인
  passwordKeyboard2(String points) => PasswordPage(points: points); // 다시 입력하기

  // 휴대전화번호를 눌러주세요.
  phoneNumberPage() => HomePage(); // 취소 X
  phoneNumberKeyboard(String points, String phoneNumber) =>
      SaveSuccessPage(points: points, phoneNumber: phoneNumber); // 확인

  // 정보 입력을 완료했습니다.
  saveSuccessPage() => HomePage(); // 나가기 X
}
