import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insta_archiver_mobile/core/di/injection.dart';
import 'package:insta_archiver_mobile/data/models/task_log_model.dart';
import 'package:insta_archiver_mobile/presentation/blocs/history_cubit.dart';
import 'package:insta_archiver_mobile/presentation/blocs/home_cubit.dart';
import 'package:insta_archiver_mobile/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskLogModelAdapter());
    await configureDependencies();

    runApp(const MyApp());
  } catch (e, stack) {
    debugPrint("CRITICAL ERROR DURING STARTUP: $e");
    debugPrint(stack.toString());
    runApp(
      MaterialApp(
        title: 'Insta Archiver',
        home: Scaffold(body: Center(child: Text("Error: $e"))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<HistoryCubit>()),
      ],
      child: MaterialApp(
        title: 'Insta Archiver',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
