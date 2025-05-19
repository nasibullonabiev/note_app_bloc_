// lib/features/notes/domain/entities/note.dart
import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, title, content, createdAt];
}