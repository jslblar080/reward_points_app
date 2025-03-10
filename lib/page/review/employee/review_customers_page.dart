import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:reward_points_app/customer.dart';
import 'package:reward_points_app/customer_list_view.dart';
import 'package:reward_points_app/secret.dart';

class ReviewCustomersPage extends StatefulWidget {
  const ReviewCustomersPage({super.key});

  @override
  State<ReviewCustomersPage> createState() => _ReviewCustomersPageState();
}

class _ReviewCustomersPageState extends State<ReviewCustomersPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Customer> customers = [];
  List<Customer> filteredCustomers = [];
  bool showPoints = false;

  @override
  void initState() {
    super.initState();
    _retrieveCustomers();
    _searchController.addListener(_filterCustomers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCustomers);
    _searchController.dispose();
    super.dispose();
  }

  _retrieveCustomers() async {
    final response = await http.get(
      Uri.https(Secret.firebaseUrl, '${Secret.firebasePath}.json'),
    );
    final Map<String, dynamic>? data = json.decode(response.body);

    setState(() {
      if (data != null) {
        customers =
            data.entries
                .map((entry) => Customer.fromJson(entry.key, entry.value))
                .toList();
        filteredCustomers = customers;
      }
      showPoints = true;
    });
  }

  _filterCustomers() {
    String query = _searchController.text;
    filteredCustomers = [];
    setState(() {
      filteredCustomers =
          customers
              .where(
                (customer) =>
                    '010-${customer.phoneNumber.substring(0, 4)}-${customer.phoneNumber.substring(4)}'
                        .startsWith(query) ||
                    '010${customer.phoneNumber.substring(0, 4)}${customer.phoneNumber.substring(4)}'
                        .startsWith(query) ||
                    customer.phoneNumber.startsWith(query),
              )
              .toList();
    });
  }

  renderCustomerListView() {
    return showPoints
        ? Expanded(child: CustomerListView(customers: filteredCustomers))
        : Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text('고객 목록'),
            SizedBox(width: 160),
            SizedBox(
              width: 280,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '010-XXXX-XXXX',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                style: TextStyle(color: Colors.black, fontSize: 20),
                cursorColor: Colors.black,
                inputFormatters: [LengthLimitingTextInputFormatter(13)],
              ),
            ),
          ],
        ),
      ),
      body: Column(children: [renderCustomerListView()]),
    );
  }
}
