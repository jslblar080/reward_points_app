import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/keyboard_config.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/secret.dart';
import 'package:reward_points_app/util/styled_text.dart';

class UsePointsPage extends StatefulWidget {
  final String phoneNumber;

  const UsePointsPage(this.phoneNumber, {super.key});

  @override
  State<UsePointsPage> createState() => _UsePointsPageState();
}

class _UsePointsPageState extends State<UsePointsPage> {
  Customer customer = Customer(
    id: '',
    phoneNumber: '',
    points: 0,
    saveCount: 0,
    pointHistories: [],
  );
  bool showPoints = false;

  @override
  void initState() {
    super.initState();
    _retrieveCustomerData();
  }

  _retrieveCustomerData() async {
    final response = await http.get(
      Uri.https(Secret.firebaseUrl, '${Secret.firebasePath}.json'),
    );
    final Map<String, dynamic>? data = json.decode(response.body);

    setState(() {
      if (data != null) {
        data.forEach((customerId, customerData) {
          if (customerData['phoneNumber'] == widget.phoneNumber) {
            customer = Customer(
              id: customerId,
              phoneNumber: customerData['phoneNumber'],
              points: customerData['points'],
              saveCount: customerData['saveCount'],
              pointHistories:
                  (customerData['pointHistories'] as List<dynamic>)
                      .map((item) => PointHistory.fromJson(item))
                      .toList(),
            );
            showPoints = true;
          }
        });
      }
      showPoints = true;
    });
  }

  renderRemainingPoints() {
    return showPoints
        ? StyledText(
          data: '${NumberFormat('#,###').format(customer.points)} P',
          color: Colors.black,
          fontsize: 25.0,
          height: 1.0,
        )
        : CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: StyledText(
          data: '사용할 포인트를 입력하세요.',
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
                    builder: (context) => PageConfig().usePointsPage(),
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
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const StyledText(
                                  data: '내 포인트',
                                  color: Colors.grey,
                                  fontsize: 25.0,
                                  height: 1.6,
                                ),
                              ],
                            ),
                            renderRemainingPoints(),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 9,
                        child: Container(color: Colors.grey[200]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(flex: 4, child: KeyboardConfig().usePointsPage(customer)),
        ],
      ),
    );
  }
}
