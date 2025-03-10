import 'package:flutter/material.dart';
import 'package:reward_points_app/config/keyboard_config.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/util/styled_text.dart';

class SavePointsPage extends StatelessWidget {
  const SavePointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: StyledText(
          data: '금액을 입력해주세요.',
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
                    builder: (context) => PageConfig().savePointsPage(),
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
      body: KeyboardConfig().savePointsPage(),
    );
  }
}
