import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_kv/firebase_options.dart';
import 'package:my_kv/logic/cubit/expence_cubit.dart';
import 'package:my_kv/logic/cubit/group_cubit.dart';
import 'package:my_kv/logic/cubit/profile_cubit.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:my_kv/routes/app_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  void initDeepLinks() {
    _appLinks.uriLinkStream.listen((uri) {
      debugPrint("Kelgan havola: $uri");

      if (uri.path.contains('/add_friend/')) {
        final friendId = uri.pathSegments.last;
        _navigateToFriendProfile(friendId);
      }
    });
  }

  void _navigateToFriendProfile(String id) {
    debugPrint("Do'st qo'shilmoqda ID: $id");

    AppRouter.router.push('/add_friend/$id');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExpenseCubit()..getExpenses()),
        BlocProvider(create: (context) => GroupCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => SettingsCubit()..loadSettings()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          Locale currentLocale = const Locale('uz');
          if (state is SettingsLoaded) {
            currentLocale = state.locale;
          }
          return MaterialApp.router(
            locale: currentLocale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('uz'), Locale('ru'), Locale('en')],
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            title: 'PlanWay',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
