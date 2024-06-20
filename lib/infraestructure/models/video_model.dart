import 'dart:typed_data';

class VideoModel {
  final int? id;
  final String title;
  final String? description;
  final String? videoData;

  VideoModel({
    this.id,
    required this.title,
    this.description,
    this.videoData,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoData: json['video_data'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'video_path': videoData,
    };
  }
}
