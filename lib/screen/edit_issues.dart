import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/model/issues_model.dart';
import 'package:redmine_mobile_app/widget/IssueDropdown.dart';
import 'package:redmine_mobile_app/widget/add_issus_input.dart';

class EditIssues extends StatefulWidget {
  const EditIssues({super.key});

  @override
  State<EditIssues> createState() => _EditIssuesState();
}

class _EditIssuesState extends State<EditIssues> {
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
                      IssueDropdown(
                        selectedValue: selectedIssueType,
                        hintText: "Select issue type",
                        items: const [
                          "Bug",
                          "Feature",
                          "Support",
                          "Documentation"
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedIssueType = newValue;
                            selectedIssueId = issueTypeIds[newValue];
                          });
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
                        "Subject : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 57),
                      AddIssusInput(
                        text: "Enter Subject",
                        onChanged: (value) {
                          subject = value;
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
                          child: TextField(
                            maxLines: null,
                            expands: true,
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
                        selectedValue: selectedStatus,
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
                        selectedValue: selectedPriority,
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
                        selectedValue: selectedDoneRatio,
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
                        child: TextField(
                          readOnly: true,
                          onTap: () => _selectDate(context, true),
                          decoration: InputDecoration(
                            hintText: selectedStartDate != null
                                ? "${selectedStartDate!.day}/${selectedStartDate!.month}/${selectedStartDate!.year}"
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
                        child: TextField(
                          readOnly: true,
                          onTap: () => _selectDate(context, false),
                          decoration: InputDecoration(
                            hintText: selectedDueDate != null
                                ? "${selectedDueDate!.day}/${selectedDueDate!.month}/${selectedDueDate!.year}"
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
                      AddIssusInput(
                        text: "Enter Estimate time",
                        onChanged: (value) {
                          estimatedHours = double.parse(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
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