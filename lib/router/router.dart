import 'package:bookexample/core/widgets/bottom_navigation_bar.dart';
import 'package:bookexample/pages/library/create_folder/create_folder_page.dart';
import 'package:bookexample/pages/library/library_page.dart';
import 'package:bookexample/pages/study/study_detail/study_datail_page.dart';
import 'package:bookexample/pages/study/study_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/study',
    routes: [
      // main shell route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            extendBody: true,
            body: navigationShell,
            bottomNavigationBar: AppBottomBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            ),
          );
        },
        branches: [
          /// STUDY TAB
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/study',
                builder: (context, state) => const StudyPage(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) => const StudyDatailPage(),
                  ),
                ],
              ),
            ],
          ),

          /// DECKS TAB
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryPage(),
                routes: [
                  GoRoute(
                    path: 'create-folder',
                    builder: (context, state) => CreateFolderPage()
                  )
                ]
              ),
            ],
          ),

          /// STATS TAB
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stats',
                builder: (context, state) => const Center(child: Text("3")),
              ),
            ],
          ),

          /// PROFILE TAB
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const Center(child: Text("4")),
              ),
            ],
          ),
        ],
      ),

      // :deckId
      GoRoute(
        path: '/study/session/:deckId',
        builder: (context, state) {
          final deckId = state.pathParameters['deckId'];
          return Center(
            child: Text("${deckId}"),
          );
        },
      ),
    ],
  );
}
