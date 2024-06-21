import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class SearchVideosUseCase implements UseCase<List<VideoEntity>, Params> {
  final VideoRepository videoRepository;

  SearchVideosUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, List<VideoEntity>>> call(Params params) async {
    return await videoRepository.searchVideos(params.query);
  }
}

class Params extends Equatable {
  final String query;

  const Params({required this.query});

  @override
  List<Object> get props => [query];
}
