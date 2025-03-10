import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/point_history_list_view.dart';
import 'package:reward_points_app/util/styled_text.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard(this.customer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 1),
            BoxShadow(
              color: Colors.grey.shade100,
              offset: Offset(-2, -2),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Text(
                '010-***${customer.phoneNumber.substring(3, 4)}-${customer.phoneNumber.substring(4)}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('보유 ', style: TextStyle(fontSize: 20)),
                  Text(
                    '${NumberFormat('#,###').format(customer.points)} P',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 33, 117, 243),
                    ),
                  ),
                  Text(
                    '                           적립 ${customer.saveCount}회',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll<Color>(
                        Colors.indigo,
                      ),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Colors.white,
                      ),
                    ),
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Row(
                                      children: [
                                        Text('포인트 내역'),
                                        SizedBox(width: 160),
                                        ElevatedButton(
                                          onPressed:
                                              () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => PageConfig()
                                                          .customerCard(
                                                            customer,
                                                          ),
                                                ),
                                              ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: StadiumBorder(),
                                          ),
                                          child: const StyledText(
                                            data: "보유 포인트 수정",
                                            color: Colors.indigo,
                                            fontsize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  body: Column(
                                    children: [
                                      Expanded(
                                        child: PointHistoryListView(
                                          customer: customer,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                        ),
                    child: Text('날짜 별 조회 / 보유 포인트 수정'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
