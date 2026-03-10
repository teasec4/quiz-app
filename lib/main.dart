import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/core/theme/app_theme.dart';

import 'package:bookexample/l10n/app_localizations.dart';
import 'package:bookexample/router/router.dart';
import 'package:bookexample/view_models/base_view_model.dart';
import 'package:bookexample/view_models/library_view_model.dart';
import 'package:bookexample/view_models/locale_view_model.dart';
import 'package:bookexample/view_models/stats_view_model.dart';
import 'package:bookexample/view_models/study_session_view_model.dart';
import 'package:bookexample/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<LibraryViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<StatsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<StudySessionViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ThemeViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<LocaleViewModel>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize theme asynchronously
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeViewModel = Provider.of<ThemeViewModel>(
        context,
        listen: false,
      );
      themeViewModel.initialize();

      final localeViewModel = Provider.of<LocaleViewModel>(
        context,
        listen: false,
      );
      localeViewModel.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeViewModel, LocaleViewModel>(
      builder: (context, themeViewModel, localeViewModel, child) {
        // Use a default theme while loading to avoid null theme
        final theme = themeViewModel.state == ViewState.loading
            ? AppThemeFactory.getTheme(AppThemeVariant.minimal)
            : themeViewModel.currentTheme;

        return MaterialApp.router(
          title: 'QuizLet',
          debugShowCheckedModeBanner: false,
          theme: theme,
          locale: localeViewModel.currentLocale,
          supportedLocales: localeViewModel.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
