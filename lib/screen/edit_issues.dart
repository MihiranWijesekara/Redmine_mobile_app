import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';

import 'package:redmine_mobile_app/model/single_issues_model.dart';
import 'package:redmine_mobile_app/widget/IssueDropdown.dart';
import 'package:redmine_mobile_app/widget/add_issus_input.dart';

class EditIssues extends StatefulWidget {
  final SingleIssuesModel singleIssuesModel;
  const EditIssues({super.key, required this.singleIssuesModel});

  @override
  State<EditIssues> createState() => _EditIssuesState();
}

class _EditIssuesState extends State<EditIssues> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  String subject = '';
  String description = '';
  double estimatedHours = 0;

  // Variables to hold selected values
  String? selectedIssueType;
  int? selectedIssueId;
  int? selectedstatusIds;
  String? selectedStatus;
  int? selectedpriorityTypeIds;
  String? selectedPriority;
  int? selecteddoneRationValue;
  String? selectedDoneRatio;
  DateTime? selectedStartDate;
  DateTime? selectedDueDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = pickedDate;
        } else {
          selectedDueDate = pickedDate;
        }
      });
    }
  }

  String getFormattedStartDate() {
    return selectedStartDate != null
        ? "${selectedStartDate!.year.toString().padLeft(4, '0')}-${selectedStartDate!.month.toString().padLeft(2, '0')}-${selectedStartDate!.day.toString().padLeft(2, '0')}"
        : '';
  }

  String getFormattedDueDate() {
    return selectedDueDate != null
        ? "${selectedDueDate!.year.toString().padLeft(4, '0')}-${selectedDueDate!.month.toString().padLeft(2, '0')}-${selectedDueDate!.day.toString().padLeft(2, '0')}"
        : '';
  }

  @override
  void initState() {
    super.initState();
    subject = widget.singleIssuesModel.subject;
    description = widget.singleIssuesModel.description;
    estimatedHours = widget.singleIssuesModel.estimatedHours;
    selectedIssueId = widget.singleIssuesModel.tracker?.id;
    selectedStartDate = widget.singleIssuesModel.startDate != null
        ? DateTime.parse(widget.singleIssuesModel.startDate!)
        : null;
    selectedDueDate = widget.singleIssuesModel.dueDate != null
        ? DateTime.parse(widget.singleIssuesModel.dueDate!)
        : null;
    selectedstatusIds = widget.singleIssuesModel.status!.id;
    selectedpriorityTypeIds = widget.singleIssuesModel.priority.id;
    selecteddoneRationValue = widget.singleIssuesModel.doneRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Text(
              "Edit Issues ",
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
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Tracker : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 57),
                      SizedBox(
                        width: 230,
                        child: DropdownButtonFormField<String>(
                          //   value: selectedActivityType,
                          value: selectedIssueId != null
                              ? issueTypeIds.entries
                                  .firstWhere(
                                      (entry) => entry.value == selectedIssueId)
                                  .key
                              : null,
                          // hint: const Text("Select Activity"),
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
                            "Bug",
                            "Feature",
                            "Support",
                            "Documentation"
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedIssueType = newValue;
                              selectedIssueId = issueTypeIds[newValue];
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
                        "Subject : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 57),
                      SizedBox(
                        width: 230,
                        child: SizedBox(
                          height: 90,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            initialValue: subject,
                            decoration: InputDecoration(
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
                            onChanged: (value) {
                              subject = value;
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
                    children: [
                      const Text(
                        "Description : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 25),
                      SizedBox(
                        width: 230,
                        child: SizedBox(
                          height: 150,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            initialValue: description,
                            decoration: InputDecoration(
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
                            onChanged: (value) {
                              description = value;
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
                    children: [
                      const Text(
                        "Status : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 70),
                      IssueDropdown(
                        //  selectedValue: selectedStatus,
                        selectedValue: selectedstatusIds != null
                            ? statusIds.entries
                                .firstWhere(
                                    (entry) => entry.value == selectedstatusIds)
                                .key
                            : null,
                        hintText: "Select status type",
                        items: const ["New", "In Progress", "Completed"],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue;
                            selectedstatusIds = statusIds[newValue];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Priority : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 60),
                      IssueDropdown(
                        //  selectedValue: selectedPriority,
                        selectedValue: selectedpriorityTypeIds != null
                            ? priorityTypeIds.entries
                                .firstWhere((entry) =>
                                    entry.value == selectedpriorityTypeIds)
                                .key
                            : null,
                        hintText: "Select priority type",
                        items: const [
                          "Low",
                          "Normal",
                          "High",
                          "Urgent",
                          "Immediate"
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPriority = newValue;
                            selectedpriorityTypeIds = priorityTypeIds[newValue];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Done Ratio : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 25),
                      IssueDropdown(
                        // selectedValue: selectedDoneRatio,
                        //selectedDoneRatio
                        selectedValue: selecteddoneRationValue != null
                            ? doneRationValueIds.entries
                                .firstWhere((entry) =>
                                    entry.value == selecteddoneRationValue)
                                .key
                            : null,
                        hintText: "Select Done Ratio ",
                        items: const [
                          "0%",
                          "10%",
                          "20%",
                          "30%",
                          "40%",
                          "50%",
                          "60%",
                          "70%",
                          "80%",
                          "90%",
                          "100%"
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDoneRatio = newValue;
                            selecteddoneRationValue = doneRationValue[newValue];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Start Date : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 235,
                        child: TextFormField(
                          initialValue: selectedStartDate != null
                              ? "${selectedStartDate!.day.toString().padLeft(2, '0')}/${selectedStartDate!.month.toString().padLeft(2, '0')}/${selectedStartDate!.year}"
                              : null,
                          readOnly: true,
                          onTap: () => _selectDate(context, true),
                          decoration: InputDecoration(
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Due Date : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 40),
                      SizedBox(
                        width: 230,
                        child: TextFormField(
                          initialValue: selectedDueDate != null
                              ? "${selectedDueDate!.day.toString().padLeft(2, '0')}/${selectedDueDate!.month.toString().padLeft(2, '0')}/${selectedDueDate!.year}"
                              : null,
                          readOnly: true,
                          onTap: () => _selectDate(context, false),
                          decoration: InputDecoration(
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Estimate time:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 230,
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            initialValue: estimatedHours.toString(),
                            decoration: InputDecoration(
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
                            onChanged: (value) {
                              estimatedHours = double.parse(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final SingleIssuesModel singleIssues =
                              SingleIssuesModel(
                                  tracker: Tracker(id: selectedIssueId ?? 0),
                                  subject: subject,
                                  description: description,
                                  status: Status(id: selectedstatusIds ?? 0),
                                  priority: Priority(
                                      id: selectedpriorityTypeIds ?? 0),
                                  doneRatio: selecteddoneRationValue ?? 0,
                                  startDate: getFormattedStartDate(),
                                  dueDate: getFormattedDueDate(),
                                  estimatedHours: estimatedHours);

                          final result = await apiService.updatedSingleIssues(
                              widget.singleIssuesModel.id!, singleIssues);
                          if (result != null) {
                            // Show success dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Success"),
                                  content:
                                      const Text("Issues saved successfully!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pop(); // Close both the dialog and the add screen
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Information"),
                                  content:
                                      const Text("Issues saved successfully"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (error) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content:
                                    Text("Failed to update Issues: $error"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 16, 134, 231),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
