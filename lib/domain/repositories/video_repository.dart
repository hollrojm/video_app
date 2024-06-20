import 'package:dartz/dartz.dart';
import 'package:video_app/domain/entities/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Exception, List<VideoEntity>>> fetchVideos();
}
