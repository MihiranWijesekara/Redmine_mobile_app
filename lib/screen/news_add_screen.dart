import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/widget/add_issus_input.dart';

class NewsAddScreen extends StatefulWidget {
  const NewsAddScreen({super.key});

  @override
  State<NewsAddScreen> createState() => _NewsAddScreenState();
}

class _NewsAddScreenState extends State<NewsAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Text(
              "Add News",
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
                            //  selectedUserType = newValue;
                            //  selectedUserId = UserId[newValue];
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
                            //  selectedUserId = UserId[newValue];
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
                      child: Container(
                        height: 55,
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
                            //  description = value;
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
                      "Summary  ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF706E6E),
                      ),
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 230,
                      child: Container(
                        height: 70,
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
                            //  description = value;
                          },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
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
                      child: Container(
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
                            //  description = value;
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
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 145, 155, 141),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Add News",
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
      ),
    );
  }
}
