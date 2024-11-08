import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redmine_mobile_app/api/api_service.dart';
import 'package:redmine_mobile_app/model/news_model.dart';

class NewsCard extends StatelessWidget {
  final ApiService apiService = ApiService();

  NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: apiService.fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No News data available."));
        }

        NewsModel newsModel = snapshot.data!.first;

        return SizedBox(
          width: double.infinity,
          child: Container(
            height: 310,
            width: 400,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 226, 226),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title: ${newsModel.title}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Summary: ${newsModel.summary}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Description: ${newsModel.description}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Created On: ${DateFormat('yyyy-MM-dd').format(newsModel.createdOn!)}",
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic),
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
}
