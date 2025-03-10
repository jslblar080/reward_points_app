import 'package:flutter/material.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/point_history_card.dart';

class PointHistoryListView extends StatelessWidget {
  final Customer customer;

  const PointHistoryListView({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customer.pointHistories.length,
      itemBuilder:
          (ctx, idx) =>
              PointHistoryCard(customer.pointHistories.reversed.toList()[idx]),
    );
  }
}
