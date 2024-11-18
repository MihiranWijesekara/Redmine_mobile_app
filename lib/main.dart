import 'package:flutter/material.dart';

import 'package:redmine_mobile_app/screen/main_screen.dart';
import 'package:redmine_mobile_app/screen/single_SpentTime.dart';
import 'package:redmine_mobile_app/screen/single_issues_screen.dart';
import 'package:redmine_mobile_app/screen/single_news_screen.dart';

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
    //  home: SingleIssuesScreen(IssuesId :1),
    );
  }
}
