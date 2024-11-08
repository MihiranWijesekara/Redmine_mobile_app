class TrackerList {
  final int id;
  final String name;

  TrackerList({
    required this.id,
    required this.name,
  });

  factory TrackerList.fromJson(Map<String, dynamic> json) {
    return TrackerList(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  get issueTypes => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
