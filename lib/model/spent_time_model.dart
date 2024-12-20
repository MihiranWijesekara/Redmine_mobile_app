class TimeEntry {
  final int? id;
  final Project? project;
  final Issue? issue;
  final User? user;
  final Activity? activity;
  final double? hours;
  final String? comments;
  final String? spentOn;

  TimeEntry({
    this.id,
    this.project,
    this.issue,
    this.user,
    this.activity,
    this.hours,
    this.comments,
    this.spentOn,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      project: json['project'] != null
          ? Project.fromJson(json['project'])
          : null, // Fix here
      issue: json['issue'] != null ? Issue.fromJson(json['issue']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      activity:
          json['activity'] != null ? Activity.fromJson(json['activity']) : null,
      hours: json['hours'] != null ? json['hours'].toDouble() : null,
      comments: json['comments'],
      spentOn: json['spent_on'],
    );
  }

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

class Issue {
  final int id;
  final String? name;

  Issue({this.name, required this.id});

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

class Activity {
  final int id;
  final String name;

  Activity({required this.id, required this.name});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
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
