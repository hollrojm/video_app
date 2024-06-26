import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/domain/usecases/use_cases_export.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_state.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_status.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetAllVideosUseCase getAllVideos;
  final CreateVideoUseCase createVideo;
  final UpdateVideoUseCase updateVideo;
  final DeleteVideoUseCase deleteVideo;

  VideoCubit({
    required this.getAllVideos,
    required this.createVideo,
    required this.updateVideo,
    required this.deleteVideo,
  }) : super(VideoState(status: VideoStatus.initial));

  Future<void> loadVideos() async {
    emit(state.copyWith(status: VideoStatus.loading));
    final result = await getAllVideos(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: failure.message,
      )),
      (videos) => emit(state.copyWith(
        status: VideoStatus.success,
        videos: videos,
      )),
    );
  }

  Future<void> addVideo(VideoEntity video, File videoFile) async {
    emit(state.copyWith(status: VideoStatus.loading));
    final result = await createVideo(CreateVideoParams(video, videoFile));
    result.fold(
      (failure) => emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: failure.message,
      )),
      (newVideo) => emit(state.copyWith(
        status: VideoStatus.success,
        videos: [...state.videos, newVideo],
      )),
    );
  }

  Future<void> editVideo(VideoEntity video, File? videoFile) async {
    emit(state.copyWith(status: VideoStatus.loading));
    final result = await updateVideo(UpdateVideoParams(video, videoFile!));
    result.fold(
      (failure) => emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: failure.message,
      )),
      (updatedVideo) {
        final updatedVideos = state.videos
            .map((v) => v.id == updatedVideo.id ? updatedVideo : v)
            .toList();
        emit(state.copyWith(
          status: VideoStatus.success,
          videos: updatedVideos,
        ));
      },
    );
  }

  Future<void> removeVideo(int id) async {
    emit(state.copyWith(status: VideoStatus.loading));
    final result = await deleteVideo(DeleteVideoParams(id: id));
    result.fold(
      (failure) => emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        final updatedVideos = state.videos.where((v) => v.id != id).toList();
        emit(state.copyWith(
          status: VideoStatus.success,
          videos: updatedVideos,
        ));
      },
    );
  }
}
