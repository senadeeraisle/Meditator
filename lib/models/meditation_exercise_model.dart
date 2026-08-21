class MeditationExercise {
  final String category;
  final String name;
  final String description;
  final int duration;
  final String audioUrl;
  final String videoUrl;

  MeditationExercise({
    required this.category,
    required this.name,
    required this.description,
    required this.duration,
    required this.audioUrl,
    required this.videoUrl,
  });

  factory MeditationExercise.fromJson(Map<String, dynamic> json) {
    return MeditationExercise(
      category: json['categoty'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      audioUrl: json['audio_url'],
      videoUrl: json['video_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'name': name,
      'description': description,
      'duration': duration,
      'audio_url': audioUrl,
      'video_url': videoUrl,
    };
  }
}
