import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class CreateVideoUseCase implements UseCase<VideoEntity, CreateVideoParams> {
  final VideoRepository videoRepository;

  CreateVideoUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, VideoEntity>> call(params) async {
    return await videoRepository.createVideo(params.video, params.file);
  }
}

class CreateVideoParams {
  final VideoEntity video;
  final File file;

  CreateVideoParams(this.video, this.file);
}
