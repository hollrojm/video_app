import 'package:flutter/material.dart';
import 'package:video_app/domain/entities/video_entity.dart';

class VideoFormDialog extends StatefulWidget {
  const VideoFormDialog({super.key, this.videoEntity, required this.onSubmit});

  final VideoEntity? videoEntity;
  final Function(VideoEntity) onSubmit;

  @override
  State<VideoFormDialog> createState() => _VideoFormDialogState();
}

class _VideoFormDialogState extends State<VideoFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.videoEntity!.title);
    _descriptionController =
        TextEditingController(text: widget.videoEntity!.description);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.videoEntity == null ? 'Añadir Video' : 'Editar Video'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final video = VideoEntity(
              id: widget.videoEntity?.id ?? 0,
              title: _titleController.text,
              description: _descriptionController.text,
              videoData: widget.videoEntity?.videoData ?? '',
            );
            widget.onSubmit(video);
          },
          child: const Text('Guardar'),
        )
      ],
    );
  }
}
