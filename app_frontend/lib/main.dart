import 'package:app_frontend/screen/AddExperienceScreen/presentation/cubits/AddExperience_Cubit.dart';
import 'package:app_frontend/screen/AddExperienceScreen/presentation/cubits/EditExperience/EditExperience_cubit.dart';
import 'package:app_frontend/screen/Explore/BOOKMARK/presentation/cubit/bookmark_cubit.dart';
import 'package:app_frontend/screen/Place_DetailedScreen/ExperienceOfPlace/presentation/experienceofplace_cubit.dart';
import 'package:app_frontend/screen/Place_DetailedScreen/presentation/cubit/place_detailedScreen_cubit.dart';
import 'package:app_frontend/screen/ProfileScreen/AddFriend/presentation/addfriend_cubit.dart';
import 'package:app_frontend/screen/ProfileScreen/EditProfile/Presentation/cubit/EditProfileCubit.dart';
import 'package:app_frontend/screen/ProfileScreen/bookmarkedexperience/presentation/bookmarkedexperience_cubit.dart';
import 'package:app_frontend/screen/ProfileScreen/experiencebyuser/presentation/experiencebyuser_cubit.dart';
import 'package:app_frontend/screen/ProfileScreen/isFriend/cubit/isfriend_cubit.dart';
import 'package:app_frontend/screen/ProfileScreen/presentation/Profilecubit/ProfileCubit.dart';
import 'package:app_frontend/screen/ProfileScreen/unfriend/presentation/unfriend_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'constant/di/di.dart';
import 'constant/navigation/autorouter.dart';
import 'constant/theme/themehelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(
          create: (context) => ExperienceByUserCubit(),
        ),
        BlocProvider(
          create: (context) => BookmarkedExperienceCubit(),
        ),
        BlocProvider(
          create: (context) => AddFriendCubit(),
        ),
        BlocProvider(
          create: (context) => UnFriendCubit(),
        ),
        BlocProvider(
          create: (context) => IsFriendCubit(),
        ),
        BlocProvider(create: (context) {
          print("place detail main.dart");
          return Place_DetailedCubit();
        }),
        BlocProvider(
          create: (context) => ExperienceOfPlaceCubit(),
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
