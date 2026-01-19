import 'package:flutter/material.dart';
import 'features/todo/presentation/pages/home_page.dart';
import 'core/theme/app_theme.dart';


class TodoDSAApp extends StatelessWidget {
  const TodoDSAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSA Todo Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}