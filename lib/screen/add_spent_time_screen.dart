import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/issues_model.dart';
import 'package:redmine_mobile_app/model/spent_time_model.dart';
import 'package:redmine_mobile_app/widget/add_issus_input.dart';

class AddSpentTimeScreen extends StatefulWidget {
  const AddSpentTimeScreen({super.key});

  @override
  State<AddSpentTimeScreen> createState() => _AddSpentTimeScreenState();
}

class _AddSpentTimeScreenState extends State<AddSpentTimeScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  int? selectedIssueId;
  List<IssuesModel> issues = [];

  @override
  void initState() {
    super.initState();
    fetchIssues();
  }

  Future<void> fetchIssues() async {
    try {
      // Fetch issues from ApiService and update state
      List<IssuesModel> fetchedIssues = await apiService.fetchIssues();
      setState(() {
        issues = fetchedIssues;
      });
    } catch (e) {
      print("Error fetching issues: $e");
    }
  }

  double hours = 0.0;
  String comments = '';

  int? selectedUserId;
  int? selectedActivityIds;
  String? selectedUserType;
  String? selectedActivityType;

  static const Map<String, int> UserId = {
    "Achintha": 1,
  };
  static const Map<String, int> ActivityIds = {
    "Development": 9,
    "Design": 8,
  };

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Text(
              "Add Spent Time",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 3, 1, 58),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Issue : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: SizedBox(
                        width: 230,
                        child: DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: selectedIssueId,
                          hint: const Text("Select Issue"),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                          ),
                          items: issues.map((issue) {
                            return DropdownMenuItem<int>(
                              value: issue.id,
                              child: Text(
                                issue.subject,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedIssueId = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "User : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 230,
                      child: DropdownButtonFormField<String>(
                        value: selectedUserType,
                        hint: const Text("Select User"),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            )),
                        items: <String>[
                          "Achintha",
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUserType = newValue;
                            selectedUserId = UserId[newValue];
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Date : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    const SizedBox(width: 25),
                    SizedBox(
                      width: 230,
                      child: TextField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                            hintText: selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "Select a date",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Spent Hours : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    AddIssusInput(
                      text: "Enter Spent Hours",
                      // controller: spentHoursController,
                      onChanged: (value) {
                        hours = double.parse(value);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Comment : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    const SizedBox(width: 1),
                    AddIssusInput(
                      text: "Enter Comment",
                      onChanged: (value) {
                        comments = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Activity : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 230,
                      child: DropdownButtonFormField<String>(
                        value: selectedActivityType,
                        hint: const Text("Select Activity"),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            )),
                        items: <String>["Design", "Development"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedActivityType = newValue;
                            selectedActivityIds = ActivityIds[newValue];
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Printing all input data in the debug console
                      print('Selected Issue ID: $selectedIssueId');
                      print('Spent Hours: $hours');
                      print('Comment: $comments');
                      print('User ID: $selectedUserId');
                      print('User Name: $selectedUserType');
                      print('Activity Type: $selectedActivityType');
                      print('Activity ID: $selectedActivityIds');
                      if (selectedDate != null) {
                        print(
                          'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        );
                      } else {
                        print('Date: Not selected');
                      }
                    } else {
                      print('Please fill in all required fields.');
                    }

                    final newtimeEntry = TimeEntry(
                      issue: Issue(id: selectedIssueId ?? 0),
                      user: User(
                          id: selectedUserId ?? 0,
                          name: selectedUserType ?? ''),
                      spentOn:
                          "${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}",
                      hours: hours,
                      comments: comments,
                      activity: Activity(
                          id: selectedActivityIds ?? 0,
                          name: selectedActivityType ?? ''),
                    );
                    await apiService.addSpentTime(newtimeEntry);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF94cc80),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Add Spent Time",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
