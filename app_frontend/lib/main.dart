import 'package:app_frontend/screen/ImagePickerScreen/ImagePickerScreen.dart';
import 'package:app_frontend/screen/AddExperienceScreen/AddExperienceScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import 'constant/theme/themehelper.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('detail');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: theme.backgroundColor),
      home: const ImagePickerScreen(),
    );
  }
}
