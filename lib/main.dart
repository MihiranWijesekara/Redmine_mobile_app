import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/screen/Issues_List.dart';
import 'package:redmine_mobile_app/screen/add_issues.dart';
import 'package:redmine_mobile_app/screen/add_spent_time_screen.dart';
import 'package:redmine_mobile_app/screen/issues_add(ex).dart';
import 'package:redmine_mobile_app/screen/main_screen.dart';
import 'package:redmine_mobile_app/screen/spent_time_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      // home: IssuesAdd(),
    );
  }
}
