import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/keyboard_config.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/util/styled_text.dart';

class PhoneNumberPage extends StatelessWidget {
  final String points;

  const PhoneNumberPage({super.key, required this.points});

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
                    builder: (context) => PageConfig().phoneNumberPage(),
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
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: const Alignment(0, 0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StyledText(
                                  data:
                                      '${NumberFormat('#,###').format(int.parse(points))} P',
                                  color: const Color.fromARGB(
                                    255,
                                    33,
                                    117,
                                    243,
                                  ),
                                  fontsize: 25.0,
                                  height: 1.8,
                                ),
                                const StyledText(
                                  data: '를',
                                  color: Colors.grey,
                                  fontsize: 25.0,
                                  height: 1.7,
                                ),
                              ],
                            ),
                            const StyledText(
                              data: '적립합니다',
                              color: Colors.grey,
                              fontsize: 25.0,
                              height: 1.8,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Container(color: Colors.grey[200]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(flex: 4, child: KeyboardConfig().phoneNumberPage(points)),
        ],
      ),
    );
  }
}
