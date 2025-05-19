import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/di/injection.dart';
import 'features/notes/data/models/note.dart';
import 'features/notes/presentation/bloc/note_bloc.dart';
import 'features/notes/presentation/bloc/theme_bloc.dart';
import 'features/notes/presentation/pages/note_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NoteBloc>()..add(LoadNotes())),
        BlocProvider(create: (_) => getIt<ThemeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Note App',
            theme: state.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const NoteListPage(),
          );
        },
      ),
    );
  }
}
