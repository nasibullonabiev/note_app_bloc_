import 'package:hive/hive.dart';

import '../models/note.dart';

abstract class NoteLocalDataSource {
  Future<List<Note>> getNotes();
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final box = Hive.box<Note>('notes');

  @override
  Future<List<Note>> getNotes() async {
    return box.values.toList();
  }

  @override
  Future<void> addNote(Note note) async {
    await box.put(note.id, note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await box.put(note.id, note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await box.delete(id);
  }
}
