import 'dart:typed_data';

class VideoModel {
  final int? id;
  final String title;
  final String? description;
  final Uint8List? videoData;

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
      videoData: json['video_data'] != null
          ? Uint8List.fromList(json['video_data'].cast<int>())
          : null,
    );
  }
}
