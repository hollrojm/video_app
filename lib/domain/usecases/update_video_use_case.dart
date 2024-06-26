import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class UpdateVideoUseCase implements UseCase<VideoEntity, UpdateVideoParams> {
  final VideoRepository videoRepository;

  UpdateVideoUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, VideoEntity>> call(params) async {
    return await videoRepository.updateVideo(params.video, params.file);
  }
}

class UpdateVideoParams {
  final VideoEntity video;
  final File file;

  UpdateVideoParams(this.video, this.file);
}
