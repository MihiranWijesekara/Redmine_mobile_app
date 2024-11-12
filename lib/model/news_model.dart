import 'package:intl/intl.dart';

class NewsModel {
  final int? id;
  final Project project;
  final Author author;
  final String title;
  final String summary;
  final String description;
  final DateTime? createdOn;

  NewsModel({
    this.id,
    required this.project,
    required this.author,
    required this.title,
    required this.summary,
    required this.description,
    this.createdOn,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? 0,
      project: Project.fromJson(json['project']),
      author: Author.fromJson(json['author']),
      title: json['title'],
      summary: json['summary'],
      description: json['description'],
      createdOn: json['created_on'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['created_on'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'news': {
        'project_id': project.id,
        'author_id': author.id,
        'title': title,
        'summary': summary,
        'description': description,
        'created_on': createdOn != null
            ? DateFormat('yyyy-MM-dd').format(createdOn!)
            : null,
      }
    };
  }
}

class Project {
  final int id;
  final String? name;

  Project({required this.id, this.name});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Author {
  final int id;
  final String? name;

  Author({required this.id, this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
