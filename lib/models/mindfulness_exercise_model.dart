class MindfulnessExercise {
  final String category;
  final String name;
  final String description;
  final List<String> instructions;
  final int duration;
  final String instructionsUrl;
  final String imagePath;

  MindfulnessExercise({
    required this.category,
    required this.name,
    required this.description,
    required this.instructions,
    required this.duration,
    required this.instructionsUrl,
    required this.imagePath,
  });

  factory MindfulnessExercise.fromJson(Map<String, dynamic> json) {
    return MindfulnessExercise(
      category: json['category'],
      name: json['name'],
      description: json['description'],
      instructions: List<String>.from(json['instructions']),
      duration: json['duration'],
      instructionsUrl: json['instructions-url'],
      imagePath: json['image-path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'name': name,
      'description': description,
      'instructions': instructions,
      'duration': duration,
      'instructions-url': instructionsUrl,
      'image-path': imagePath,
    };
  }
}
