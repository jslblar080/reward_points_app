import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reward_points_app/config/page_config.dart';

void main() async {
  await initializeDateFormatting('ko_KR', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageConfig().main(),
    );
  }
}
