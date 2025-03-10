import 'package:flutter/material.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/secret.dart';
import 'package:reward_points_app/util/styled_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60.0,
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        centerTitle: true,
        title: StyledText(
          data: 'ⓘ 직원에게 요청을 해주세요.',
          color: Colors.white,
          fontsize: 20.0,
          height: -0.85,
        ),
      ),
      body: Container(
        alignment: const Alignment(0, -0.15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 214, 214, 214),
              Colors.white,
              Color.fromARGB(255, 214, 214, 214),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText(
              data: Secret.logo1,
              color: Color.fromARGB(255, 33, 117, 243),
            ),
            StyledText(data: Secret.logo2, color: Colors.grey),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 95,
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StyledText(
                    data: Secret.logo1,
                    color: Color.fromARGB(255, 33, 117, 243),
                    fontsize: 25.0,
                  ),
                  StyledText(
                    data: Secret.logo2,
                    color: Colors.grey,
                    fontsize: 25.0,
                  ),
                  StyledText(
                    data: Secret.logo3,
                    color: Colors.black,
                    fontsize: 25.0,
                  ),
                ],
              ),
              const SizedBox(width: 200), // 600
              SizedBox(
                width: 165,
                child: ElevatedButton(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageConfig().homePage1(),
                        ),
                      ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    //foregroundColor: Colors.black,
                    shape: const LinearBorder(),
                  ),
                  child: const StyledText(
                    data: '사용/조회',
                    color: Colors.black,
                    fontsize: 19,
                  ),
                ),
              ),
              SizedBox(
                width: 165,
                child: ElevatedButton(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageConfig().homePage2(),
                        ),
                      ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 33, 117, 243),
                    //foregroundColor: Colors.white,
                    shape: const LinearBorder(),
                  ),
                  child: const StyledText(
                    data: '포인트 적립',
                    color: Colors.white,
                    fontsize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
