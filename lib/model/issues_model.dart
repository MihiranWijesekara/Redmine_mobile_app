import 'package:intl/intl.dart';

class IssuesModel {
  final int? id;
  final Tracker tracker;
  final Status status;
  final Priority priority;
  final Author author;
  final String subject;
  final String description;
  final String? startDate;
  final String? dueDate;
  final int doneRatio;
  final double estimatedHours;
  final String createdOn;
  final String? closedOn;

  final int? statusId;
  final int? trackerId;
  final int? priorityId;

  IssuesModel({
    this.id,
    required this.tracker,
    required this.status,
    required this.priority,
    required this.author,
    required this.subject,
    required this.description,
    this.startDate,
    this.dueDate,
    required this.doneRatio,
    required this.estimatedHours,
    required this.createdOn,
    this.closedOn,
    this.statusId,
    this.trackerId,
    this.priorityId,
  });

  factory IssuesModel.fromJson(Map<String, dynamic> json) {
    return IssuesModel(
      id: json['id'] ?? 0,
      tracker: json['tracker'] != null
          ? Tracker.fromJson(json['tracker'])
          : Tracker(id: 0, name: "Unknown"),
      status: json['status'] != null
          ? Status.fromJson(json['status'])
          : Status(id: 0, name: "Unknown", isClosed: false),
      priority: json['priority'] != null
          ? Priority.fromJson(json['priority'])
          : Priority(id: 0, name: "Unknown"),
      author: json['author'] != null
          ? Author.fromJson(json['author'])
          : Author(id: 0, name: "Unknown"),
      subject: json['subject'] ?? "",
      description: json['description'] ?? "",
      startDate: json['start_date'],
      dueDate: json['due_date'],
      doneRatio: json['done_ratio'] ?? 0,
      estimatedHours: (json['estimated_hours'] ?? 0).toDouble(),
      createdOn: json['created_on'] ?? "",
      closedOn: json['closed_on'],
      statusId: json['status_id'],
      trackerId: json['tracker_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issue': {
        'tracker_id': tracker.id,
        'status_id': status.id,
        'priority_id': priority.id,
        'subject': subject,
        'description': description,
        'start_date': startDate,
        'due_date': dueDate,
        'done_ratio': doneRatio,
        'is_private': false,
        'estimated_hours': estimatedHours,
      }
    };
  }

  // Add this empty constructor
  IssuesModel.empty()
      : subject = '',
        startDate = '',
        dueDate = '',
        tracker = Tracker(id: 0, name: "Unknown"),
        status = Status(id: 0, name: "Unknown", isClosed: false),
        priority = Priority(id: 0, name: "Unknown"),
        author = Author(id: 0, name: "Unknown"),
        description = '',
        doneRatio = 0,
        estimatedHours = 0.0,
        id = 0,
        createdOn = '',
        closedOn = null,
        statusId = null,
        trackerId = null,
        priorityId = null;
}

// Your existing fromJson() and other methods...

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

const Map<String, int> doneRationValue = {
  "0%": 0,
  "10% ": 10,
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
