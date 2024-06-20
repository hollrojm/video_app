import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final Uint8List? videoData;

  const VideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.videoData,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoData,
      ];
}
