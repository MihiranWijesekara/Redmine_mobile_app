class SingleSpenttimeModel {
  final int? id;
  final Project? project; 
  final Issue? issue; 
  final User? user; 
  final Activity? activity; 
  final double? hours;
  final String? comments;
  final String? spentOn;

  SingleSpenttimeModel({
    this.id,
    this.project, 
    this.issue, 
    this.user, 
    this.activity,
    this.hours,
    this.comments,
    this.spentOn,
  });

  /// Factory method to parse JSON data into a SingleSpenttimeModel object
  factory SingleSpenttimeModel.fromJson(Map<String, dynamic> json) {
    final timeEntryData = json['time_entry'];
    if (timeEntryData == null || timeEntryData is! Map<String, dynamic>) {
      throw Exception("Invalid JSON structure: 'time_entry' key is missing or not a map.");
    }

    return SingleSpenttimeModel(
      id: timeEntryData['id'] as int?,
      project: timeEntryData['project'] != null
          ? Project.fromJson(timeEntryData['project'])
          : null,
      issue: timeEntryData['issue'] != null
          ? Issue.fromJson(timeEntryData['issue'])
          : null,
      user: timeEntryData['user'] != null
          ? User.fromJson(timeEntryData['user'])
          : null,
      activity: timeEntryData['activity'] != null
          ? Activity.fromJson(timeEntryData['activity'])
          : null,
      hours: (timeEntryData['hours'] as num?)?.toDouble(),
      comments: timeEntryData['comments'] ?? 'No Comments',
      spentOn: timeEntryData['spent_on'],
    );
  }

  /// Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'time_entry': {
        'issue_id': issue?.id,
        'user_id': user?.id,
        'activity_id': activity?.id,
        'hours': hours,
        'comments': comments,
        'spent_on': spentOn,
      }
    };
  }
}

class Project {
  final int id;
  final String name;

  Project({required this.id, required this.name});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Issue {
  final int id;
  final String? name;

  Issue({required this.id, this.name});

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'] as int,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Activity {
  final int id;
  final String name;

  Activity({required this.id, required this.name});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
