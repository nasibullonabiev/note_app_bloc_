import 'package:get_it/get_it.dart';

import '../../features/notes/data/datasources/note_local_data_source.dart';
import '../../features/notes/data/repositories/note_repository_impl.dart';
import '../../features/notes/domain/repositories/note_repository.dart';
import '../../features/notes/domain/usecases/add_note.dart';
import '../../features/notes/domain/usecases/delete_note.dart';
import '../../features/notes/domain/usecases/get_notes.dart';
import '../../features/notes/domain/usecases/update_note.dart';
import '../../features/notes/presentation/bloc/note_bloc.dart';
import '../../features/notes/presentation/bloc/theme_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Data sources
  getIt.registerLazySingleton<NoteLocalDataSource>(
          () => NoteLocalDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<NoteRepository>(
          () => NoteReposistoryImpl(localDataSource: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetNotes(getIt()));
  getIt.registerLazySingleton(() => AddNote(getIt()));
  getIt.registerLazySingleton(() => UpdateNote(getIt()));
  getIt.registerLazySingleton(() => DeleteNote(getIt()));

  // Blocs
  getIt.registerFactory(() => NoteBloc(
    getNotes: getIt(),
    addNote: getIt(),
    updateNote: getIt(),
    deleteNote: getIt(),
  ));
  getIt.registerFactory(() => ThemeBloc());
}