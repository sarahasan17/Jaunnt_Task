import 'package:app_frontend/screen/AddExperienceScreen/presentation/AddExperienceScreen.dart';
import 'package:app_frontend/screen/ProfileScreen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'constant/theme/themehelper.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('detail');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: theme.backgroundColor),
      home: const AddExperienceScreen(),
    );
  }
}
