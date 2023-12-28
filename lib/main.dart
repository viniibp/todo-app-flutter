import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/cubit/tasks/task.logics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp/cubit/tasks/tasks.bloc.dart';

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt')],
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        hintColor: Colors.white70,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.dark,
        ),
      ),
      home: BlocProvider(
        create: (context) => TasksCubit()..getTasks(),
        child: const TaskCubitLogics(),
      ),
    ),
  );
}
