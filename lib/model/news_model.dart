import 'package:intl/intl.dart';

class NewsModel {
  final String title;
  final String summary;
  final String description;
  final DateTime? createdOn; // Make createdOn nullable

  NewsModel({
    required this.title,
    required this.summary,
    required this.description,
    this.createdOn,
  });


  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      summary: json['summary'] ?? '', 
      description: json['description'] ?? '', 
      createdOn: json['created_on'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['created_on']) 
          : null, 
    );
  }
}
