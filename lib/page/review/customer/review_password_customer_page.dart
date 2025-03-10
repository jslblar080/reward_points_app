import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/keyboard_config.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/util/styled_text.dart';

class ReviewPasswordCustomerPage extends StatelessWidget {
  final Customer customer;
  final String usePoints;

  const ReviewPasswordCustomerPage({
    super.key,
    required this.customer,
    required this.usePoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: StyledText(
          data:
              '사용자: 010-***${customer.phoneNumber.substring(3, 4)}-${customer.phoneNumber.substring(4)}                       사용 포인트: ${NumberFormat('#,###').format(int.parse(usePoints))} P',
          color: Colors.black,
          fontsize: 20.0,
          height: -0.75,
        ),
        actions: [
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PageConfig().reviewPasswordCustomerPage(),
                  ),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: LinearBorder(),
            ),
            child: const StyledText(
              data: "취소 X",
              color: Colors.black,
              fontsize: 18,
            ),
          ),
        ],
      ),
      body: KeyboardConfig().reviewPasswordCustomerPage(usePoints, customer),
    );
  }
}
