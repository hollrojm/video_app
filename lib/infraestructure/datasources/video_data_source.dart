import 'dart:io';

import 'package:dio/dio.dart';
import 'package:video_app/core/exceptions.dart';
import 'package:video_app/infraestructure/models/video_model.dart';

abstract class VideoDataSource {
  Future<List<VideoModel>> getAllVideos();
  Future<VideoModel> getVideo(int id);
  Future<VideoModel> createVideo(VideoModel video, File videoFile);
  Future<VideoModel> updateVideo(VideoModel video, File videoFile);
  Future<void> deleteVideo(int id);
}

class VideoDataSourceImpl implements VideoDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.101.7:8000/api/videos";

  VideoDataSourceImpl({required this.dio});
  @override
  Future<VideoModel> createVideo(VideoModel video, File videoFile) async {
    try {
      final response = await dio.post(baseUrl,
          data: FormData.fromMap({
            'title': video.title,
            'description': video.description,
            'video': await MultipartFile.fromFile(videoFile.path),
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
  Future<VideoModel> updateVideo(VideoModel video, File videoFile) async {
    try {
      final Map<String, dynamic> data = {
        'title': video.title,
        'description': video.description,
      };

      data['video'] = await MultipartFile.fromFile(videoFile.path);

      final formData = FormData.fromMap(data);

      final response = await dio.put('$baseUrl/${video.id}', data: formData);
      return VideoModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException('Network error: ${e.message}', message: '');
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 404) {
            return NotFoundException('Resource not found');
          } else if (e.response?.statusCode == 400) {
            return ValidationException(
                'Validation error: ${e.response?.data['message']}');
          }
          break;
        default:
          break;
      }
    }
    return ServerException('Server error: ${e.toString()}', message: '');
  }
}
