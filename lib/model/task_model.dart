class Taskodel {
  final String id;
  final String title;
  final String description;
  bool isCompleted;

  Taskodel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false
  });

  // Convert object to Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  // Convert Map to object
  factory Taskodel.fromJson(Map<String, dynamic> json) {
    return Taskodel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}
