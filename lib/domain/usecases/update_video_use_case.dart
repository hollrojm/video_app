import 'package:dartz/dartz.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class UpdateVideoUseCase implements UseCase<VideoEntity, VideoEntity> {
  final VideoRepository videoRepository;

  UpdateVideoUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, VideoEntity>> call(VideoEntity videoEntity) async {
    return await videoRepository.updateVideo(videoEntity);
  }
}
