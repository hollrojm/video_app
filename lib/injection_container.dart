import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:video_app/domain/repositories/video_repository.dart';
import 'package:video_app/domain/usecases/get_video_use_case.dart';
import 'package:video_app/domain/usecases/use_cases_export.dart';
import 'package:video_app/infraestructure/datasources/video_data_source.dart';
import 'package:video_app/infraestructure/repositories_impl/video_repository_impl.dart';

import 'package:video_app/presentation/ui/screens/home/cubit/video_cubit.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  serviceLocator.registerFactory(
    () => VideoCubit(
      getAllVideos: serviceLocator(),
      createVideo: serviceLocator(),
      updateVideo: serviceLocator(),
      deleteVideo: serviceLocator(),
    ),
  );
  // Use cases
  serviceLocator.registerLazySingleton(
      () => GetAllVideosUseCase(videoRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetVideoUseCase(videoRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => CreateVideoUseCase(videoRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => UpdateVideoUseCase(videoRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => DeleteVideoUseCase(videoRepository: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(videoDataSource: serviceLocator()),
  );

  // Data sources
  serviceLocator.registerLazySingleton<VideoDataSource>(
    () => VideoDataSourceImpl(dio: Dio()),
  );
}
