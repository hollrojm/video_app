import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_app/domain/entities/video_entity.dart';

class VideoFormDialog extends StatefulWidget {
  const VideoFormDialog({super.key, this.videoEntity, required this.onSubmit});

  final VideoEntity? videoEntity;
  final Function(VideoEntity, File) onSubmit;

  @override
  State<VideoFormDialog> createState() => _VideoFormDialogState();
}

class _VideoFormDialogState extends State<VideoFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  File? _videoFile;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.videoEntity!.title);
    _descriptionController =
        TextEditingController(text: widget.videoEntity!.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
      });
    }
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
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text(
                _videoFile != null ? 'Cambiar Video' : 'Seleccionar Video'),
          ),
          if (_videoFile != null)
            Text('Archivo seleccionado: ${_videoFile!.path.split('/').last}'),
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
            widget.onSubmit(video, _videoFile!);
          },
          child: const Text('Guardar'),
        )
      ],
    );
  }
}
