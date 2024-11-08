import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/spent_time_model.dart';
import 'package:redmine_mobile_app/screen/add_spent_time_screen.dart';

class SpentTimeScreen extends StatefulWidget {
  const SpentTimeScreen({super.key});

  @override
  State<SpentTimeScreen> createState() => _SpentTimeScreenState();
}

class _SpentTimeScreenState extends State<SpentTimeScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Text(
              "Spent Time",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 3, 1, 58),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<TimeEntry>>(
        future: apiService.fetchSpenttime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Spent Time Found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final timeEntry = snapshot.data![index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    height: 255,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFD1FEC4),
                          Color(0xFFD1FEC4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Issues  : ",
                                    style: TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Text(
                                      timeEntry.project!.name,
                                      style: const TextStyle(
                                        color: Color(0xFF626264),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  Text(
                                    timeEntry.id.toString(),
                                    style: TextStyle(
                                      color: Color(0xFF626264).withOpacity(0.2),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Activity  : ",
                                    style: TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Text(
                                      timeEntry.activity.name,
                                      style: const TextStyle(
                                        color: Color(0xFF626264),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Comment  : ",
                                    style: TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      timeEntry.comments,
                                      style: const TextStyle(
                                        color: Color(0xFF626264),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "User  : ",
                                    style: TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 55),
                                  Expanded(
                                    child: Text(
                                      timeEntry.user.name,
                                      style: const TextStyle(
                                        color: Color(0xFF626264),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Date  : ",
                                    style: TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    timeEntry.spentOn,
                                    style: const TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                  const SizedBox(width: 30),
                                  const Text(
                                    "Spent Hours  : ",
                                    style: TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    timeEntry.hours.toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF626264),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
            MaterialPageRoute(builder: (context) => const AddSpentTimeScreen()),
          );
        },
        backgroundColor: const Color(0xFF68B0AB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
