import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/theme_bloc.dart';
import 'note_edit_page.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Switch(
                value: state.isDarkMode,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                activeTrackColor: Colors.white70,
                inactiveTrackColor: Colors.grey,
              );
            },
          ),
          const SizedBox(width: 8), // Add some padding
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title.isEmpty ? 'Untitled' : note.title),
                  subtitle: Text(note.content.isEmpty ? 'No content' : note.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteEditPage(note: note),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<NoteBloc>().add(DeleteNoteEvent(note.id));
                    },
                  ),
                );
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final note = NoteEntity(
            id: const Uuid().v4(),
            title: '',
            content: '',
            createdAt: DateTime.now(),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoteEditPage(note: note, isNew: true),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}