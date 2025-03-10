import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/secret.dart';
import 'package:reward_points_app/util/styled_text.dart';

class UseSuccessPage extends StatefulWidget {
  final String usePoints;
  final Customer customer;

  const UseSuccessPage({
    super.key,
    required this.usePoints,
    required this.customer,
  });

  @override
  State<UseSuccessPage> createState() => _UseSuccessPageState();
}

class _UseSuccessPageState extends State<UseSuccessPage> {
  @override
  void initState() {
    super.initState();
    _updateCustomerData();
  }

  _updateCustomerData() async {
    String existingCustomerKey = widget.customer.id;
    int existingPoints = widget.customer.points;
    int existingSaveCount = widget.customer.saveCount;
    List<PointHistory> existingPointHistories = widget.customer.pointHistories;

    final newPointHistory = PointHistory(
      dateTime: DateTime.now().add(Duration(hours: Secret.timeDifference)),
      pointChange: -int.parse(widget.usePoints),
    );
    existingPointHistories.add(newPointHistory);

    await http.patch(
      Uri.https(
        Secret.firebaseUrl,
        '${Secret.firebasePath}/$existingCustomerKey.json',
      ),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'points': existingPoints - int.parse(widget.usePoints),
        'saveCount': existingSaveCount,
        'pointHistories':
            existingPointHistories.map((e) => e.toJson()).toList(),
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        centerTitle: true,
        title: StyledText(
          data: '정보 입력을 완료했습니다.',
          color: Colors.white,
          fontsize: 20.0,
          height: -0.75,
        ),
        actions: [
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageConfig().useSuccessPage(),
                  ),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 49, 49),
              shape: const LinearBorder(),
            ),
            child: const StyledText(
              data: "나가기 X",
              color: Colors.white,
              fontsize: 18,
            ),
          ),
        ],
      ),
      body: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledText(
                    data:
                        '${NumberFormat('#,###').format(widget.customer.points)} P',
                    color: Color.fromARGB(255, 33, 117, 243),
                    fontsize: 85,
                    height: 1,
                  ),
                  StyledText(
                    data: ' ➔ ',
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontsize: 70,
                    height: 1,
                  ),
                  StyledText(
                    data:
                        '${NumberFormat('#,###').format(widget.customer.points - int.parse(widget.usePoints))} P',
                    color: Color.fromARGB(255, 33, 117, 243),
                    fontsize: 85,
                    height: 1,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: StyledText(
                data:
                    '사용 포인트: ${NumberFormat('#,###').format(int.parse(widget.usePoints))} P',
                color: Colors.black,
                fontsize: 40,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '010-***${widget.customer.phoneNumber.substring(3, 4)}-${widget.customer.phoneNumber.substring(4)}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
