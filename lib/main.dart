import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:bookexample/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(getIt<LibraryRepository>()),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // .minimal .tech .modern
      theme: AppThemeFactory.getTheme(AppThemeVariant.minimal),
      routerConfig: AppRouter.router,
    );
  }
}

