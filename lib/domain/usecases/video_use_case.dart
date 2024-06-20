import 'package:dartz/dartz.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class VideoUseCase implements UseCase<List<VideoEntity>, Unit> {
  final VideoRepository _videoRepository;

  VideoUseCase({
    required VideoRepository videoRepository,
  }) : _videoRepository = videoRepository;
  @override
  Future<Either<Exception, List<VideoEntity>>> call(Unit params) {
    return _videoRepository.fetchVideos();
  }
}
