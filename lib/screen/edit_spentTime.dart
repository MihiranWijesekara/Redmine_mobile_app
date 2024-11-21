import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/issues_model.dart';
import 'package:redmine_mobile_app/model/single_spentTime_model.dart';
import 'package:redmine_mobile_app/widget/add_issus_input.dart';

class EditSpenttime extends StatefulWidget {
  final SingleSpenttimeModel singleSpenttimeModel;
  const EditSpenttime({super.key, required this.singleSpenttimeModel});

  @override
  State<EditSpenttime> createState() => _EditSpenttimeState();
}

class _EditSpenttimeState extends State<EditSpenttime> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  int? selectedIssueId;
  List<IssuesModel> issues = [];

  Future<void> fetchIssues() async {
    try {
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
    "Development": 21,
    "General": 20,
  };
  @override
  void initState() {
    super.initState();
    fetchIssues();
    hours = widget.singleSpenttimeModel.hours!;
    comments = widget.singleSpenttimeModel.comments!;
    selectedIssueId = widget.singleSpenttimeModel.issue?.id;
    selectedUserId = widget.singleSpenttimeModel.user?.id;
    selectedActivityIds = widget.singleSpenttimeModel.activity?.id;
    selectedDate = widget.singleSpenttimeModel.spentOn != null
        ? DateTime.parse(widget.singleSpenttimeModel.spentOn!)
        : null;
  }

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

  String getFormattedDate() {
    return selectedDate != null
        ? "${selectedDate!.year.toString().padLeft(4, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Text(
              "Edit Spent Time",
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
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 230,
                      child: DropdownButtonFormField<String>(
                        hint: const Text("Select User"),
                        value: selectedUserId != null &&
                                UserId.containsValue(selectedUserId)
                            ? UserId.entries
                                .firstWhere(
                                    (entry) => entry.value == selectedUserId)
                                .key
                            : null,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
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
                      child: TextFormField(
                        initialValue: selectedDate != null
                            ? "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}"
                            : null,
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
                    SizedBox(
                      width: 230,
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          initialValue: hours.toString(),
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
                            hours = double.parse(value);
                          },
                        ),
                      ),
                    )
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
                    SizedBox(
                      width: 230,
                      child: SizedBox(
                        height: 100,
                        child: TextFormField(
                          initialValue: comments,
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
                            comments = value;
                          },
                        ),
                      ),
                    )
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
                        //   value: selectedActivityType,

                        value: selectedActivityIds != null &&
                                ActivityIds.containsValue(selectedActivityIds)
                            ? ActivityIds.entries
                                .firstWhere((entry) =>
                                    entry.value == selectedActivityIds)
                                .key
                            : null,
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
                        items: <String>["Development", "General"]
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
                    if (_formKey.currentState!.validate()) {
                      try {
                        final SingleSpenttimeModel singleSpenttimeModel =
                            SingleSpenttimeModel(
                          issue: Issue(id: selectedIssueId ?? 0),
                          user: User(
                              id: selectedUserId ?? 0,
                              name: selectedUserType ?? ''),
                          spentOn: getFormattedDate(),
                          hours: hours,
                          comments: comments,
                          activity: Activity(
                              id: selectedActivityIds ?? 0,
                              name: selectedActivityType ?? ''),
                        );

                        final result = await apiService.updatedSpentTime(
                            widget.singleSpenttimeModel.id!,
                            singleSpenttimeModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Spent time Update successfully!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to Update spent time. Please try again.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
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
                    "Save",
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
