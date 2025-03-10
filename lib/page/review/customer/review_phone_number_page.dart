import 'package:flutter/material.dart';
import 'package:reward_points_app/config/keyboard_config.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/util/styled_text.dart';

class ReviewPhoneNumberPage extends StatelessWidget {
  const ReviewPhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const StyledText(
          data: '휴대전화번호를 눌러주세요.',
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
                    builder: (context) => PageConfig().reviewPhoneNumberPage(),
                  ),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const LinearBorder(),
            ),
            child: const StyledText(
              data: "취소 X",
              color: Colors.black,
              fontsize: 18,
            ),
          ),
        ],
      ),
      body: KeyboardConfig().reviewPhoneNumberPage(),
    );
  }
}
