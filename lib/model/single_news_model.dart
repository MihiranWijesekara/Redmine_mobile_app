import 'package:intl/intl.dart';

class SingleNewsModel {
  final int? id;
  final Project project;
  final Author author;
  final String? title;
  final String? summary;
  final String? description;
  final DateTime? createdOn;

  SingleNewsModel({
    this.id,
    required this.project,
    required this.author,
    this.title,
    this.summary,
    this.description,
    this.createdOn,
  });

  /// Factory method to parse JSON data into a NewsModel object
  factory SingleNewsModel.fromJson(Map<String, dynamic> json) {
    final newsData = json['news'];
    if (newsData == null || newsData is! Map<String, dynamic>) {
      throw Exception("Invalid JSON structure: 'news' key is missing or not a map.");
    }

    return SingleNewsModel(
      id: newsData['id'] ?? 0,
      project: Project.fromJson(newsData['project'] ?? {}),
      author: Author.fromJson(newsData['author'] ?? {}),
      title: newsData['title'] ?? 'Untitled',
      summary: newsData['summary'] ?? 'No Summary Provided',
      description: newsData['description'] ?? 'No Description Available',
      createdOn: newsData['created_on'] != null
          ? DateTime.tryParse(newsData['created_on'])
          : null,
    );
  }

  /// Converts NewsModel object to JSON for serialization
  Map<String, dynamic> toJson() {
    return {
      'news': {
        'id': id,
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

  /// Factory method to parse JSON data into a Project object
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unnamed Project',
    );
  }

  /// Converts Project object to JSON for serialization
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

  /// Factory method to parse JSON data into an Author object
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Author',
    );
  }

  /// Converts Author object to JSON for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
