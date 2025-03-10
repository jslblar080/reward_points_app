import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/keyboard_config.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/util/styled_text.dart';

class PasswordPage extends StatelessWidget {
  final String points;

  const PasswordPage({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: StyledText(
          data: '적립 포인트: ${NumberFormat('#,###').format(int.parse(points))} P',
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
                    builder: (context) => PageConfig().passwordPage(),
                  ),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const LinearBorder(),
            ),
            child: const StyledText(
              data: "뒤로가기",
              color: Colors.black,
              fontsize: 18,
            ),
          ),
        ],
      ),
      body: KeyboardConfig().passwordPage(points),
    );
  }
}
