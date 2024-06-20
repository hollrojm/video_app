import 'package:dio/dio.dart';
import 'package:video_app/core/exceptions.dart';
import 'package:video_app/infraestructure/models/video_model.dart';

abstract class VideoDataSource {
  Future<List<VideoModel>> getAllVideos();
  Future<VideoModel> getVideo(int id);
  Future<VideoModel> createVideo(VideoModel video);
  Future<VideoModel> updateVideo(VideoModel video);
  Future<void> deleteVideo(int id);
  Future<List<VideoModel>> searchVideos(String query);
}

class VideoDataSourceImpl implements VideoDataSource {
  final Dio dio;
  final String baseUrl = 'http://localhost:8000/api/videos';

  VideoDataSourceImpl({required this.dio});
  @override
  Future<VideoModel> createVideo(VideoModel video) async {
    try {
      final response = await dio.post(baseUrl,
          data: FormData.fromMap({
            'title': video.title,
            'description': video.description,
            'video': await MultipartFile.fromFile(video.videoData!),
          }));
      return VideoModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> deleteVideo(int id) async {
    try {
      await dio.delete('$baseUrl/$id');
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<VideoModel>> getAllVideos() async {
    try {
      final response = await dio.get(baseUrl);
      return (response.data as List)
          .map((json) => VideoModel.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<VideoModel> getVideo(int id) async {
    try {
      final response = await dio.get('$baseUrl/$id');
      return VideoModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<VideoModel> updateVideo(VideoModel video) async {
    try {
      final response = await dio.put(
        '$baseUrl/${video.id}',
        data: video.toJson(),
      );
      return VideoModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<VideoModel>> searchVideos(String query) async {
    try {
      final response =
          await dio.get('$baseUrl/search', queryParameters: {'q': query});
      return (response.data as List)
          .map((json) => VideoModel.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(e) {
    if (e.type == e.connectTimeout ||
        e.type == e.receiveTimeout ||
        e.type == e.sendTimeout) {
      return NetworkException('Network error: ${e.message}', message: '');
    } else if (e.response?.statusCode == 404) {
      return NotFoundException('Resource not found');
    } else if (e.response?.statusCode == 400) {
      return ValidationException(
          'Validation error: ${e.response?.data['message']}');
    } else {
      return ServerException('Server error: ${e.message}', message: '');
    }
  }
}
