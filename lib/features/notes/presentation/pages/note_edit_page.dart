import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';

class NoteEditPage extends StatefulWidget {
  final NoteEntity note;
  final bool isNew;

  const NoteEditPage({Key? key, required this.note, this.isNew = false})
      : super(key: key);

  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNew ? 'New Note' : 'Edit Note'),
        actions: [
          if (!widget.isNew)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<NoteBloc>().add(DeleteNoteEvent(widget.note.id));
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final updatedNote = NoteEntity(
            id: widget.note.id,
            title: _titleController.text,
            content: _contentController.text,
            createdAt: widget.note.createdAt,
          );
          context.read<NoteBloc>().add(
            widget.isNew
                ? AddNoteEvent(updatedNote)
                : UpdateNoteEvent(updatedNote),
          );
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}