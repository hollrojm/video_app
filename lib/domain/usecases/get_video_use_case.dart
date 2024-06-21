import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class GetVideoUseCase implements UseCase<VideoEntity, Params> {
  final VideoRepository videoRepository;

  GetVideoUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, VideoEntity>> call(params) async {
    return await videoRepository.getVideo(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
