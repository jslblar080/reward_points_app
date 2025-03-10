import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/secret.dart';
import 'package:reward_points_app/util/styled_text.dart';
import 'package:http/http.dart' as http;

class SaveSuccessPage extends StatefulWidget {
  final String points;
  final String phoneNumber;

  const SaveSuccessPage({
    super.key,
    required this.points,
    required this.phoneNumber,
  });

  @override
  State<SaveSuccessPage> createState() => _SaveSuccessPageState();
}

class _SaveSuccessPageState extends State<SaveSuccessPage> {
  int remainingPoints = 0;
  bool showPoints = false;

  @override
  void initState() {
    super.initState();
    _submitCustomerData();
  }

  _submitCustomerData() async {
    final url = Uri.https(Secret.firebaseUrl, '${Secret.firebasePath}.json');

    final response1 = await http.get(url);
    final Map<String, dynamic>? data1 = json.decode(response1.body);

    String? existingCustomerKey;
    int existingPoints = 0;
    int existingSaveCount = 0;
    List<PointHistory> existingPointHistories = [];

    if (data1 != null) {
      data1.forEach((customerId, customerData) {
        if (customerData['phoneNumber'] == widget.phoneNumber) {
          existingCustomerKey = customerId;
          existingPoints = customerData['points'];
          existingSaveCount = customerData['saveCount'];
          existingPointHistories =
              (customerData['pointHistories'] as List<dynamic>)
                  .map((item) => PointHistory.fromJson(item))
                  .toList();
        }
      });
    }

    final newPointHistory = PointHistory(
      dateTime: DateTime.now().add(Duration(hours: Secret.timeDifference)),
      pointChange: int.parse(widget.points),
    );
    existingPointHistories.add(newPointHistory);

    if (existingCustomerKey != null) {
      final updateUrl = Uri.https(
        Secret.firebaseUrl,
        '${Secret.firebasePath}/$existingCustomerKey.json',
      );

      await http.patch(
        updateUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'points': existingPoints + int.parse(widget.points),
          'saveCount': existingSaveCount + 1,
          'pointHistories':
              existingPointHistories.map((e) => e.toJson()).toList(),
        }),
      );
    } else {
      await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phoneNumber': widget.phoneNumber,
          'points': int.parse(widget.points),
          'saveCount': 1,
          'pointHistories': [newPointHistory.toJson()],
        }),
      );
    }

    final response2 = await http.get(
      Uri.https(Secret.firebaseUrl, '${Secret.firebasePath}.json'),
    );
    final Map<String, dynamic> data2 = json.decode(response2.body);

    setState(() {
      data2.forEach((customerId, customerData) {
        if (customerData['phoneNumber'] == widget.phoneNumber) {
          remainingPoints = customerData['points'];
          showPoints = true;
        }
      });
    });
  }

  renderRemainingPoints() {
    return showPoints
        ? Text(
          '${NumberFormat('#,###').format(remainingPoints)} P ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
        : CircularProgressIndicator();
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
                    builder: (context) => PageConfig().saveSuccessPage(),
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
            SizedBox(height: 8),
            Center(
              child: StyledText(
                data:
                    '${NumberFormat('#,###').format(int.parse(widget.points))} P',
                color: Color.fromARGB(255, 33, 117, 243),
                fontsize: 85,
                height: 1,
              ),
            ),
            Center(
              child: StyledText(
                data: '적립 완료',
                color: Colors.black,
                fontsize: 50,
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledText(
                    data: '보유 포인트는 ',
                    color: Colors.grey,
                    fontsize: 30,
                  ),
                  renderRemainingPoints(),
                  StyledText(data: '입니다', color: Colors.grey, fontsize: 30),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 250,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Container(color: Colors.white, width: 20),
                  Image.asset('assets/yellow_coin.jpg'),
                  Expanded(
                    child: Container(
                      alignment: Alignment(-0.9, 0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            '1,000 P 부터',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('포인트 사용 가능', style: TextStyle(fontSize: 25)),
                        ],
                      ),
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
