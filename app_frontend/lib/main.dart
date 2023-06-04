import 'package:app_frontend/screen/AddExperienceScreen/presentation/cubits/AddExperience_Cubit.dart';
import 'package:app_frontend/screen/AddExperienceScreen/presentation/cubits/EditExperience/EditExperience_cubit.dart';
import 'package:app_frontend/screen/Explore/BOOKMARK/presentation/cubit/bookmark_Cubit.dart';
import 'package:app_frontend/screen/ProfileScreen/EditProfile/Presentation/cubit/EditProfileCubit.dart';
import 'package:app_frontend/screen/ProfileScreen/presentation/Profilecubit/ProfileCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'constant/di/di.dart';
import 'constant/navigation/autorouter.dart';
import 'constant/theme/themehelper.dart';

void main() async {
  initGetIt();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await Hive.initFlutter();
  await Hive.openBox('detail');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    ThemeHelper theme = ThemeHelper();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => EditProfileCubit(),
        ),
        BlocProvider(
          create: (context) => AddExperienceCubit(),
        ),
        BlocProvider(
          create: (context) => EditExperienceCubit(),
        ),
        BlocProvider(
          create: (context) => BookmarkCubit(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(scaffoldBackgroundColor: theme.backgroundColor),
        debugShowCheckedModeBanner: false,
        routeInformationParser:
            router.defaultRouteParser(includePrefixMatches: true),
        routerDelegate: router.delegate(
          initialRoutes: [const BottomNavbar()],
        ),
      ),
    );
    /**MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: theme.backgroundColor),
      home: const ProfileScreen(),
    );**/
  }
}
