import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/single_spentTime_model.dart';
import 'package:redmine_mobile_app/screen/edit_spentTime.dart';

class SingleSpenttime extends StatefulWidget {
  final int spentTimeId;
  SingleSpenttime({super.key, required this.spentTimeId});

  @override
  State<SingleSpenttime> createState() => _SingleSpenttimeState();
}

class _SingleSpenttimeState extends State<SingleSpenttime> {
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
        body: FutureBuilder<SingleSpenttimeModel>(
            future: apiService.fetchSpentTimeId(widget.spentTimeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("error:  ${snapshot.error} "),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("Spent Time Not found"),
                );
              }
              SingleSpenttimeModel singletimeEntry = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Project  : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: Text(
                                singletimeEntry.project!.name,
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
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text(
                              "Activity  : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Text(
                                singletimeEntry.activity?.name ?? '',
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
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text(
                              "Comment  : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                singletimeEntry?.comments ?? '',
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
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text(
                              "User  : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 55),
                            Expanded(
                              child: Text(
                                singletimeEntry.user?.name ?? '',
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
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text(
                              "create Date  : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              singletimeEntry.spentOn ?? '',
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
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              "Spent Hours  : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              singletimeEntry.hours.toString(),
                              style: TextStyle(
                                color: Color(0xFF626264),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /*
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        if (timeEntry.id != null) {
                                          await apiService
                                              .deleteSpentTime(timeEntry.id!);
                                          setState(() {
                                            snapshot.data!.removeAt(index);
                                          });
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Spent Time deleted successfully')),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Spent Time ID is missing. Cannot delete Spent Time.')),
                                          );
                                        }
                                      } catch (error) {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Failed to delete Spent Time: $error')),
                                        );
                                      }
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 213, 5, 19),
                                    ),
                                  ),
                                   */
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  EditSpenttime(singleSpenttimeModel : singletimeEntry)),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 10, 44, 213),
                          ),
                        ),
                      ],
                    ),
                      ]
                  ),
                ),
                ),
              );
            }));
  }
}
