import 'package:video_app/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required int id,
    required String title,
    required String description,
    required String videoData,
  }) : super(
            id: id,
            title: title,
            description: description,
            videoData: videoData);

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
