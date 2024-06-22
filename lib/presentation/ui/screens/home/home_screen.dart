import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/domain/entities/video_entity.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_cubit.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_state.dart';
import 'package:video_app/presentation/ui/screens/home/cubit/video_status.dart';
import 'package:video_app/presentation/widgets/widgets_export.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideosApp'),
        centerTitle: true,
      ),
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          switch (state.status) {
            case VideoStatus.initial:
              return const Center(
                child: Text('No videos'),
              );
            case VideoStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case VideoStatus.success:
              return _buildVideoList(context, state.videos);
            case VideoStatus.error:
              return Center(
                  child: Text(state.errorMessage ?? "A ocurrido un error"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddVideoDialog(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

Widget _buildVideoList(BuildContext context, List<VideoEntity> videos) {
  return ListView.builder(
    itemCount: videos.length,
    itemBuilder: (context, index) {
      final video = videos[index];
      return ListTile(
        title: Text(video.title ?? '!!!Sin titulo'),
        subtitle: Text(video.description ?? '!!! Sin descripción'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditVideoDialog(context, video),
            ),
            IconButton(
              onPressed: () => _showDeleteConfirmationDialog(context, video.id),
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      );
    },
  );
}

void _showAddVideoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => VideoFormDialog(
      onSubmit: (video) {
        context.read<VideoCubit>().addVideo(video);
        Navigator.of(context).pop();
      },
    ),
  );
}

void _showEditVideoDialog(BuildContext context, VideoEntity video) {
  showDialog(
    context: context,
    builder: (context) => VideoFormDialog(
      videoEntity: video,
      onSubmit: (updatedVideo) {
        context.read<VideoCubit>().editVideo(updatedVideo);
        Navigator.of(context).pop();
      },
    ),
  );
}

void _showDeleteConfirmationDialog(BuildContext context, int videoId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar'),
      content: const Text('Estas seguro que quieres eliminar este video?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<VideoCubit>().removeVideo(videoId);
            Navigator.of(context).pop();
          },
          child: const Text('Video Eliminado'),
        ),
      ],
    ),
  );
}
