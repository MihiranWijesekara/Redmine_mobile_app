import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/single_issues_model.dart';
import 'package:redmine_mobile_app/screen/Issues_List.dart';
import 'package:redmine_mobile_app/screen/edit_issues.dart';
import 'package:redmine_mobile_app/widget/Issues_priority_container.dart';

class SingleIssuesScreen extends StatefulWidget {
  final int issuesId;
  const SingleIssuesScreen({super.key, required this.issuesId});

  @override
  State<SingleIssuesScreen> createState() => _SingleIssuesScreenState();
}

class _SingleIssuesScreenState extends State<SingleIssuesScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Text(
              "Issues ",
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
        child: FutureBuilder<SingleIssuesModel?>(
            future: apiService.fetchSingleIssuesId(widget.issuesId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("Issues not found"),
                );
              }

              // Data is available
              SingleIssuesModel singleIssues = snapshot.data!;
              String priority = singleIssues.priority.name!;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Subject: ",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: singleIssues.subject,
                                style: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Description: ",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: singleIssues.description,
                                style: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Assignee : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 9, 9),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(singleIssues.author?.name ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ))
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
                                color: Color.fromARGB(255, 9, 9, 9),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (priority == "Low")
                              const IssuesPriorityContainer(
                                color: Color(0xFFA0A0A0),
                                text: 'Low',
                              ),
                            if (priority == "Normal")
                              const IssuesPriorityContainer(
                                color: Color(0xFF68B0AB),
                                text: 'Normal',
                              ),
                            if (priority == "High")
                              const IssuesPriorityContainer(
                                color: Color(0xFFFFA500),
                                text: 'High',
                              ),
                            if (priority == "Urgent")
                              const IssuesPriorityContainer(
                                color: Color(0xFFFF4500),
                                text: 'Urgent',
                              ),
                            if (priority == "Immediate")
                              const IssuesPriorityContainer(
                                color: Color(0xFFFF0000),
                                text: 'Immediate',
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
                                color: Color.fromARGB(255, 9, 9, 9),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${singleIssues.doneRatio}%",
                              style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 18,
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
                              "Estimated hours : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 9, 9),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              singleIssues.estimatedHours.toString(),
                              style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 18,
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
                              "Start date : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 9, 9),
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              singleIssues.startDate!,
                              style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Due date : ",
                                style: TextStyle(
                                  color: Color(0xFFE51B1B),
                                  fontSize: 19,
                                )),
                            Text(
                              singleIssues.dueDate!,
                              style: const TextStyle(
                                color: Color(0xFFE51B1B),
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () async {
                                try {
                                  if (singleIssues.id != null) {
                                    await apiService
                                        .deleteIssue(singleIssues.id!);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Issue deleted successfully'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => IssuesList(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Issue ID is missing. Cannot delete issue.'),
                                      ),
                                    );
                                  }
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to delete issue: $error'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditIssues(
                                            singleIssuesModel: singleIssues)));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 10, 44, 213),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
