import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/core/view_models/base_view_model.dart';
import 'package:bookexample/router/router.dart';
import 'package:bookexample/view_models/library_view_model.dart';
import 'package:bookexample/view_models/stats_view_model.dart';
import 'package:bookexample/view_models/study_session_view_model.dart';
import 'package:bookexample/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, child) {
        // Use a default theme while loading to avoid null theme
        final theme = themeViewModel.state == ViewState.loading
            ? AppThemeFactory.getTheme(AppThemeVariant.minimal)
            : themeViewModel.currentTheme;

        return MaterialApp.router(
          title: 'QuizLet',
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
