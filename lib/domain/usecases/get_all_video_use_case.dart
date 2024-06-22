import 'package:dartz/dartz.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class GetAllVideosUseCase implements UseCase<List<VideoEntity>, NoParams> {
  final VideoRepository _videoRepository;

  GetAllVideosUseCase({
    required VideoRepository videoRepository,
  }) : _videoRepository = videoRepository;

  @override
  Future<Either<Failure, List<VideoEntity>>> call(NoParams noParams) async {
    return await _videoRepository.getAllVideos();
  }
}
