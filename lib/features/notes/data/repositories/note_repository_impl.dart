import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';
import '../models/note.dart';

class NoteReposistoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteReposistoryImpl({required this.localDataSource});

  @override
  Future<List<NoteEntity>> getNotes() async {
    final noteModels = await localDataSource.getNotes();
    return noteModels.map((model) => NoteEntity(
      id: model.id,
      title: model.title,
      content: model.content,
      createdAt: model.createdAt,
    )).toList();
  }

  @override
  Future<void> addNote(NoteEntity note) async {
    await localDataSource.addNote(Note.fromEntity(note));
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    await localDataSource.updateNote(Note.fromEntity(note));
  }

  @override
  Future<void> deleteNote(String id) async {
    await localDataSource.deleteNote(id);
  }
}
