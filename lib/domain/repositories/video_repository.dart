import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/domain/entities/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Failure, List<VideoEntity>>> getAllVideos();
  Future<Either<Failure, VideoEntity>> getVideo(int id);
  Future<Either<Failure, VideoEntity>> createVideo(
      VideoEntity video, File videoFile);
  Future<Either<Failure, VideoEntity>> updateVideo(
      VideoEntity video, File videoFile);
  Future<Either<Failure, void>> deleteVideo(int id);
}
