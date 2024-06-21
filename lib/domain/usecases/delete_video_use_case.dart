import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_app/core/failures.dart';
import 'package:video_app/core/use_case.dart';
import 'package:video_app/domain/repositories/video_repository.dart';

class DeleteVideoUseCase implements UseCase<void, Params> {
  final VideoRepository videoRepository;

  DeleteVideoUseCase({required this.videoRepository});
  @override
  Future<Either<Failure, void>> call(params) async {
    return await videoRepository.deleteVideo(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
