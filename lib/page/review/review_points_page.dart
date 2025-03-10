import 'package:flutter/material.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/util/styled_text.dart';

class ReviewPointsPage extends StatelessWidget {
  const ReviewPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: StyledText(
          data: '버튼을 선택해주세요.',
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
                    builder: (context) => PageConfig().reviewPointsPage1(),
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
      body: Container(
        color: const Color.fromARGB(220, 238, 238, 238),
        alignment: Alignment(0, -0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageConfig().reviewPointsPage2(),
                    ),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                shape: StadiumBorder(),
                elevation: 6,
              ),
              child: const StyledText(
                data: "직원용",
                color: Colors.black,
                fontsize: 30,
              ),
            ),
            SizedBox(width: 280),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageConfig().reviewPointsPage3(),
                    ),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 33, 117, 243),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                shape: StadiumBorder(),
                elevation: 6,
              ),
              child: const StyledText(
                data: "고객용",
                color: Colors.white,
                fontsize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
