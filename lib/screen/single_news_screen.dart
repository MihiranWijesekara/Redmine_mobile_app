import 'package:flutter/material.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/news_model.dart';
import 'package:redmine_mobile_app/model/single_news_model.dart';
import 'package:redmine_mobile_app/screen/edit_news.dart';
import 'package:redmine_mobile_app/screen/news_screen.dart';

class SingleNewsScreen extends StatefulWidget {
  final int newsId;

  const SingleNewsScreen({super.key, required this.newsId});

  @override
  State<SingleNewsScreen> createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: Text(
              "News",
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
        child: FutureBuilder<SingleNewsModel>(
          future: apiService.fetchNewsId(widget.newsId),
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
                child: Text("News not found"),
              );
            }

            // Data is available
            SingleNewsModel singleNewsModel = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title: ${singleNewsModel.title}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Summary: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: singleNewsModel.summary,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Description: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: singleNewsModel.description,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Created On: ${singleNewsModel.createdOn != null ? singleNewsModel.createdOn!.toLocal().toString().split(' ')[0] : 'N/A'}",
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Author: ${singleNewsModel.author.name ?? 'Unknown'}",
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            if (singleNewsModel.id != null) {
                              await apiService.deleteNews(singleNewsModel.id!);

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('News deleted successfully')),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NewsScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'News ID is missing. Cannot delete News.')),
                              );
                            }
                          } catch (error) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Failed to delete News: $error')),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 213, 5, 19),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditNews(
                                      singleNewsModel: singleNewsModel)));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 10, 44, 213),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
