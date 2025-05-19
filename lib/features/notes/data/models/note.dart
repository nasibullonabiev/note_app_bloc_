import 'package:hive/hive.dart';
import 'package:note_app_bloc/features/notes/domain/entities/note.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends NoteEntity with HiveObjectMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  }) : super(id: id, title: title, content: content, createdAt: createdAt);

  factory Note.fromEntity(NoteEntity note) {
    return Note(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
    );
  }
}