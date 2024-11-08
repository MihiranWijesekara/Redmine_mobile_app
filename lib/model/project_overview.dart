import 'package:intl/intl.dart';

class ProjectOverview {
  final String description;
  final DateTime? createdOn;

  ProjectOverview({
    required this.description,
    required this.createdOn,
  });

  // Use this constructor for JSON parsing
  factory ProjectOverview.fromJson(Map<String, dynamic> json) {
    return ProjectOverview(
      description: json['description'] ?? '', // Handling missing description
      createdOn: json['created_on'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['created_on'])
          : null,
    );
  }
}
