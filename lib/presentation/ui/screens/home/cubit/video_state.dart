import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_status.dart';

class VideoState {
  final VideoStatus status;
  final List<VideoEntity> videos;
  final String? errorMessage;

  VideoState({
    required this.status,
    this.videos = const [],
    this.errorMessage,
  });
  VideoState copyWith({
    VideoStatus? status,
    List<VideoEntity>? videos,
    String? errorMessage,
  }) {
    return VideoState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
