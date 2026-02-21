import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/core/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    Center(child: Text("1")),
    Center(child: Text("2")),
    Center(child: Text("3")),
    Center(child: Text("4")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomBar(
        currentIndex: currentPageIndex,
        onTap: (i) {
          setState(() {
            currentPageIndex = i;
          });
        },
      ),
      body: pages[currentPageIndex],
    );
  }
}
