import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/issues_model.dart';
import 'package:redmine_mobile_app/screen/add_issues.dart';
import 'package:redmine_mobile_app/screen/single_issues_screen.dart';
import 'package:redmine_mobile_app/widget/Issues_priority_container.dart';

class IssuesList extends StatefulWidget {
  const IssuesList({super.key});

  @override
  State<IssuesList> createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  final ApiService apiService = ApiService();
  late Future<List<IssuesModel>> issuesFuture;

  @override
  void initState() {
    super.initState();
    issuesFuture = apiService.fetchIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Text(
              "Issues List",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 3, 1, 58),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<IssuesModel>>(
        future: issuesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Issues Found"));
          } else {
            List<IssuesModel> issuesList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: issuesList.length,
              itemBuilder: (context, index) {
                IssuesModel issues = issuesList[index];
                String priority = issues.priority.name!;
                return InkWell(
                  onTap: () {
                    print('Issue ID: ${issues.id}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleIssuesScreen(
                          issuesId: issues.id!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 260,
                              width: 375,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF68F2EB),
                                    Color(0xFF68F2EB),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      issues.subject,
                                      style: const TextStyle(
                                        color: Color(0xFF1F2563),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Assignee : ",
                                          style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          issues.author.name!,
                                          style: const TextStyle(
                                            color: Color(0xFF707070),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Priority : ",
                                          style: TextStyle(
                                            color: Color(0xFF707070),
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
                                    Row(
                                      children: [
                                        const Text(
                                          "Start date : ",
                                          style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontSize: 19,
                                          ),
                                        ),
                                        Text(
                                          issues.startDate!,
                                          style: const TextStyle(
                                            color: Color(0xFF707070),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Due date : ",
                                            style: TextStyle(
                                              color: Color(0xFFE51B1B),
                                              fontSize: 19,
                                            )),
                                        Text(
                                          issues.dueDate!,
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddIssues()),
          );
        },
        backgroundColor: const Color(0xFF68B0AB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
