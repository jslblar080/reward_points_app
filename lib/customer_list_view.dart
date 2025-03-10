import 'package:flutter/material.dart';
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/customer_card.dart';

class CustomerListView extends StatelessWidget {
  final List<Customer> customers;

  const CustomerListView({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (ctx, idx) => CustomerCard(customers[idx]),
    );
  }
}
