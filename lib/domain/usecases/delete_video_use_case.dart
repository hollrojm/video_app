import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class DeleteVideoUseCase implements UseCase<void, DeleteVideoParams> {
  final VideoRepository videoRepository;

  DeleteVideoUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, void>> call(params) async {
    return await videoRepository.deleteVideo(params.id);
  }
}

class DeleteVideoParams extends Equatable {
  final int id;

  const DeleteVideoParams({required this.id});

  @override
  List<Object> get props => [id];
}
