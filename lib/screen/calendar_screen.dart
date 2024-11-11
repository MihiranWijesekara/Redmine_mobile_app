import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/issues_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Text(
              "Calender",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 3, 1, 58),
              ),
            ),
          ),
        ),
      ),
      body: const CalendarYear(),
    );
  }
}

/*
class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Center(
              child: Text(
                "Calender",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 1, 58),
                ),
              ),
            ),
          ),
        ),
        body: const CalendarYear(),
      ),
    );
  }
}
*/
class CalendarYear extends StatefulWidget {
  const CalendarYear({super.key});

  @override
  _CalendarYearState createState() => _CalendarYearState();
}

class _CalendarYearState extends State<CalendarYear> {
  final ApiService apiService = ApiService();

  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  List<IssuesModel> issues = [];

  final List<String> daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    fetchIssues();
  }

  Future<void> fetchIssues() async {
    const String url = "http://192.168.0.9/projects/gsmb-project/issues.json";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> issuesData = json.decode(response.body)['issues'];
        setState(() {
          issues = issuesData
              .map((json) => IssuesModel.fromJson(json))
              .cast<IssuesModel>()
              .toList();
        });
      } else {
        print("Failed to fetch issues, status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching issues: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  currentMonth = currentMonth == 1 ? 12 : currentMonth - 1;
                  if (currentMonth == 12) currentYear--;
                });
              },
            ),
            Text(
              "${DateFormat.MMMM().format(DateTime(currentYear, currentMonth))} $currentYear",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  currentMonth = currentMonth == 12 ? 1 : currentMonth + 1;
                  if (currentMonth == 1) currentYear++;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: daysOfWeek.map((day) {
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                alignment: Alignment.center,
                child: Text(
                  day,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 236, 10, 59)),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 3,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color.fromARGB(255, 249, 245, 245),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemCount: _daysInMonth(currentYear, currentMonth) +
                  _startOffset(currentYear, currentMonth),
              itemBuilder: (context, index) {
                int startDayOffset = _startOffset(currentYear, currentMonth);
                if (index < startDayOffset) {
                  return Container();
                } else {
                  int dayNumber = index - startDayOffset + 1;
                  DateTime date =
                      DateTime(currentYear, currentMonth, dayNumber);

                  IssuesModel task = issues.firstWhere(
                    (issue) =>
                        issue.startDate ==
                            DateFormat('yyyy-MM-dd').format(date) ||
                        issue.dueDate == DateFormat('yyyy-MM-dd').format(date),
                    orElse: () => IssuesModel.empty(),
                  );

                  bool hasTask =
                      task.subject != null && task.subject.isNotEmpty;
                  bool isSameDayTask = task.startDate == task.dueDate &&
                      task.startDate == DateFormat('yyyy-MM-dd').format(date);

                  return GestureDetector(
                    onTap: hasTask
                        ? () {
                            print(
                                "Opening task details for date: $date, task: ${task.subject}");
                            _showTaskDetails(context, task);
                          }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: hasTask
                            ? const Color.fromARGB(255, 250, 208, 163)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: const Color.fromARGB(255, 143, 183, 252),
                            width: 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            dayNumber.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          if (hasTask)
                            Positioned(
                              bottom: 4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isSameDayTask)
                                    Transform.rotate(
                                      angle: 0.785398,
                                      child: const Icon(
                                        Icons.stop,
                                        color: Color.fromARGB(255, 37, 50, 171),
                                        size: 22,
                                      ),
                                    )
                                  else ...[
                                    if (task.startDate ==
                                        DateFormat('yyyy-MM-dd').format(date))
                                      const Icon(Icons.arrow_forward,
                                          color: Colors.green, size: 20),
                                    if (task.dueDate ==
                                        DateFormat('yyyy-MM-dd').format(date))
                                      const Icon(Icons.arrow_back,
                                          color: Colors.red, size: 20),
                                  ]
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.green,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Green Arrow is Issues Start date.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 10, 10)),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Red Arrow is Issues due date.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 10, 10)),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Transform.rotate(
                    angle: 0.785398,
                    child: const Icon(
                      Icons.stop,
                      color: Color.fromARGB(255, 37, 50, 171),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Task beginning and ending this day.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 10, 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showTaskDetails(BuildContext context, IssuesModel task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Task Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Subject: ${task.subject}"),
              const SizedBox(height: 8),
              Text("Start Date: ${task.startDate ?? 'No start date'}"),
              Text("Due Date: ${task.dueDate ?? 'No due date'}"),
              const SizedBox(height: 8),
              Text("Status: ${task.status.name ?? 'No status'}"),
              Text("Priority: ${task.priority.name ?? 'No priority'}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int _startOffset(int year, int month) {
    int weekday = DateTime(year, month, 1).weekday;
    return weekday == 7 ? 0 : weekday;
  }
}
