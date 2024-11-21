import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';

import 'package:redmine_mobile_app/model/single_news_model.dart';

class EditNews extends StatefulWidget {
  final SingleNewsModel singleNewsModel;

  const EditNews({super.key, required this.singleNewsModel});

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String summary = '';
  String description = '';

  int? selectedProjectId;
  int? selectedAuthorId;

  static const Map<String, int> ProjectId = {
    "GSMB-Project": 1,
  };
  static const Map<String, int> AuthorId = {
    "Achintha Wijesekara": 1,
  };
  @override
  void initState() {
    super.initState();
    title = widget.singleNewsModel.title!;
    summary = widget.singleNewsModel.summary!;
    description = widget.singleNewsModel.description!;
    selectedProjectId =
        widget.singleNewsModel.project.id; // Assuming you have this field
    selectedAuthorId = widget.singleNewsModel.author.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Text(
                "Edit News",
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
                        "Select Project ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 230,
                        child: DropdownButtonFormField<String>(
                          //  value: selectedUserType,
                          hint: const Text("Select Project"),
                          value: selectedProjectId != null &&
                                  ProjectId.containsValue(selectedProjectId)
                              ? ProjectId.entries
                                  .firstWhere((entry) =>
                                      entry.value == selectedProjectId)
                                  .key
                              : null,

                            

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
                            "GSMB-Project",
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              // selectedUserType = newValue;
                              selectedProjectId = ProjectId[newValue];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Select Author ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 230,
                        child: DropdownButtonFormField<String>(
                          //  value: selectedUserType,
                          hint: const Text("Select Author"),
                          value: selectedAuthorId != null
                              ? AuthorId.entries
                                  .firstWhere((entry) =>
                                      entry.value == selectedAuthorId)
                                  .key
                              : null,
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
                            "Achintha Wijesekara",
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              //  selectedUserType = newValue;
                              selectedAuthorId = AuthorId[newValue];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Title  ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 80),
                      SizedBox(
                        width: 230,
                        child: SizedBox(
                          height: 70,
                          child: TextFormField(
                              maxLines: null,
                              expands: true,
                              initialValue: title,
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
                                title = value;
                              }),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Summary  ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 230,
                        child: SizedBox(
                          height: 80,
                          child: TextFormField(
                            initialValue: summary,
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
                              summary = value;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Description  ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF706E6E),
                        ),
                      ),
                      const SizedBox(width: 30),
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          SingleNewsModel updatedNews = SingleNewsModel(
                            id: widget.singleNewsModel.id,
                            project: Project(
                              id: selectedProjectId ?? 0,
                            ),
                            author: Author(
                              id: selectedAuthorId ?? 0,
                            ),
                            title: title,
                            summary: summary,
                            description: description,
                            createdOn: DateTime.now(),
                          );

                          final result = await apiService.updatedNews(
                              widget.singleNewsModel.id!, updatedNews);

                          if (result != null) {
                            // Show success dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Success"),
                                  content:
                                      const Text("News saved successfully!"),
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
                                      const Text("News saved successfully"),
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
                                content: Text("Failed to update news: $error"),
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
                      backgroundColor: const Color.fromARGB(255, 145, 155, 141),
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
                        color: Color.fromARGB(255, 246, 241, 241),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
