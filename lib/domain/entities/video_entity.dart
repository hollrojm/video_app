import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final String? videoData;

  const VideoEntity({
    required this.id,
    this.title,
    this.description,
    this.videoData,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoData,
      ];
}
