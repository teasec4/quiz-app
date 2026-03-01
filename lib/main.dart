import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/router/router.dart';
import 'package:bookexample/view_models/library_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async {
  await setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<LibraryViewModel>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'QuizLet',
      debugShowCheckedModeBanner: false,
      // .minimal .tech .modern
      theme: AppThemeFactory.getTheme(AppThemeVariant.minimal),
      routerConfig: AppRouter.router,
    );
  }
}
