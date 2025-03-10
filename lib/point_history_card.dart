import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/customer.dart';

class PointHistoryCard extends StatelessWidget {
  final PointHistory pointHistory;

  const PointHistoryCard(this.pointHistory, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 1),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Text(
                DateFormat(
                  "yy.MM.dd (E) HH:mm:ss",
                  "ko_KR",
                ).format(pointHistory.dateTime),
                style: TextStyle(fontSize: 22),
              ),
              Spacer(),
              Text(
                (pointHistory.pointChange < 0) ? '' : '+',
                style: TextStyle(
                  fontSize: 22,
                  color:
                      (pointHistory.pointChange < 0)
                          ? Colors.red
                          : Color.fromARGB(255, 33, 117, 243),
                ),
              ),
              Text(
                '${NumberFormat('#,###').format(pointHistory.pointChange)} P',
                style: TextStyle(
                  fontSize: 22,
                  color:
                      (pointHistory.pointChange < 0)
                          ? Colors.red
                          : Color.fromARGB(255, 33, 117, 243),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
