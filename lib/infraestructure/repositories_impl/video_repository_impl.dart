import 'package:dartz/dartz.dart';
import 'package:video_app/core/exceptions.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/repositories/video_repository.dart';
import 'package:video_app/infraestructure/datasources/video_data_source.dart';
import 'package:video_app/infraestructure/models/video_model.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoDataSource videoDataSource;

  VideoRepositoryImpl({required this.videoDataSource});

  @override
  Future<Either<Failure, VideoEntity>> createVideo(VideoEntity video) async {
    try {
      final result = await videoDataSource.createVideo(VideoModel(
        id: video.id,
        title: video.title!,
        description: video.description!,
        videoData: video.videoData,
      ));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVideo(int id) async {
    try {
      await videoDataSource.deleteVideo(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getAllVideos() async {
    try {
      final result = await videoDataSource.getAllVideos();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, VideoEntity>> getVideo(int id) async {
    try {
      final result = await videoDataSource.getVideo(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> searchVideos(String query) async {
    try {
      final result = await videoDataSource.searchVideos(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, VideoEntity>> updateVideo(VideoEntity video) async {
    try {
      final result = await videoDataSource.updateVideo(VideoModel(
        id: video.id,
        title: video.title!,
        description: video.description!,
        videoData: video.videoData,
      ));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
