import 'package:intl/intl.dart';

class SingleIssuesModel {
  final int? id;
  final Tracker? tracker;
  final Status? status;
  final Priority priority;
  final Author? author;
  final String subject;
  final String description;
  final String? startDate;
  final String? dueDate;
  final int doneRatio;
  final double estimatedHours;

  SingleIssuesModel({
    this.id,
    required this.priority,
    this.author,
    this.tracker,
    this.status,
    required this.subject,
    required this.description,
    this.startDate = '',
    this.dueDate = '',
    required this.doneRatio,
    required this.estimatedHours,
  });

  factory SingleIssuesModel.fromJson(Map<String, dynamic> json) {
    return SingleIssuesModel(
      id: json['id'] ?? 0,
      priority: json['priority'] != null
          ? Priority.fromJson(json['priority'])
          : Priority(id: 0, name: "Unknown"),
      status: json['status'] != null
          ? Status.fromJson(json['status'])
          : Status(id: 0, name: "Unknown"),
      tracker: json['tracker'] != null
          ? Tracker.fromJson(json['tracker'])
          : Tracker(id: 0, name: "Unknown"),
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      subject: json['subject'] ?? 'No Subject',
      description: json['description'] ?? 'No Description',
      startDate: json['start_date'] ?? '',
      dueDate: json['due_date'] ?? '',
      doneRatio: json['done_ratio'] ?? 0,
      estimatedHours: json['estimated_hours'] != null
          ? (json['estimated_hours'] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'priority_id': priority.id,
      'subject': subject,
      'description': description,
      'start_date': startDate ?? '', // Use empty string if null
      'due_date': dueDate ?? '', // Use empty string if null
      'done_ratio': doneRatio,
      'is_private': false,
      'estimated_hours': estimatedHours,
      'status_id': status!.id,
    };

    // ignore: unnecessary_null_comparison
    return {'issue': data..removeWhere((key, value) => value == null)};
  }

  static String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    return DateFormat("yyyy-MM-dd").format(DateTime.parse(date));
  }
}

class Project {
  final int id;
  final String name;

  Project({required this.id, required this.name});

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

class Tracker {
  final int id;
  final String? name;

  Tracker({required this.id, this.name});

  factory Tracker.fromJson(Map<String, dynamic> json) {
    return Tracker(
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

class Status {
  final int id;
  final String? name;
  final bool? isClosed;

  Status({required this.id, this.name, this.isClosed});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      name: json['name'],
      isClosed: json['is_closed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_closed': isClosed,
    };
  }
}

class Priority {
  final int id;
  final String? name;

  Priority({required this.id, this.name});

  factory Priority.fromJson(Map<String, dynamic> json) {
    return Priority(
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

class AssignedTo {
  final int id;
  final String? name;

  AssignedTo({required this.id, this.name});

  factory AssignedTo.fromJson(Map<String, dynamic> json) {
    return AssignedTo(
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

// Mapping of issue types to IDs
const Map<String, int> issueTypeIds = {
  "Bug": 1,
  "Feature": 2,
  "Support": 3,
  "Documentation": 4,
};

const Map<String, int> statusIds = {
  "New": 1,
  "In Progress": 2,
  "Completed": 3,
};

const Map<String, int> priorityTypeIds = {
  "Low": 1,
  "Normal": 2,
  "High": 3,
  "Urgent": 4,
  "Immediate": 5,
};

Map<String, int> doneRationValueIds = {
  "0%": 0,
  "10%": 10,
  "20%": 20,
  "30%": 30,
  "40%": 40,
  "50%": 50,
  "60%": 60,
  "70%": 70,
  "80%": 80,
  "90%": 90,
  "100%": 100,
};

final doneRationValue = Map.fromIterable(
  List.generate(11, (index) => index * 10),
  key: (value) => "${value}%",
  value: (value) => value,
);
