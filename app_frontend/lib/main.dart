import 'package:app_frontend/screen/share_experience_screen/share_experience_screen.dart';
import 'package:flutter/material.dart';

import 'constant/theme/themehelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: theme.backgroundColor),
      home: const AddExperienceScreen(),
    );
  }
}
