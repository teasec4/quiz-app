import 'package:bookexample/core/theme/theme_preview_page.dart';
import 'package:bookexample/core/widgets/bottom_navigation_bar.dart';
import 'package:bookexample/pages/library/folder/create_deck/create_deck.dart';

import 'package:bookexample/pages/library/folder/deck/deck_page.dart';
import 'package:bookexample/pages/library/folder/folder_page.dart';
import 'package:bookexample/pages/library/library_page.dart';
import 'package:bookexample/pages/session/flashcards_session.dart';
import 'package:bookexample/pages/settings/settings_page.dart';
import 'package:bookexample/pages/stats/stats_page.dart';
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
                routes: [],
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
                    path: 'folder/:folderId',
                    builder: (context, state) {
                      final folderId = state.pathParameters['folderId'];
                      return FolderPage(folderId: folderId ?? "");
                    },
                    routes: [
                      GoRoute(
                        path: 'deck/:deckId',
                        builder: (context, state) {
                          final folderId = state.pathParameters['folderId'];
                          final deckId = state.pathParameters['deckId'];
                          return DeckPage(
                            folderId: folderId ?? "",
                            deckId: deckId ?? "",
                          );
                        },
                      ),
                      GoRoute(
                        path: 'createdeck',                   
                        builder: (context, state) {
                        final folderId = state.pathParameters['folderId'];
                          return CreateDeck(
                            folderId: folderId ?? "",
                          );
                        },
                      ),
                      GoRoute(
                        path: 'editdeck/:deckId',
                        builder: (context, state) {
                          final folderId = state.pathParameters['folderId'];
                          final deckId = state.pathParameters['deckId'];
                          return CreateDeck(
                            folderId: folderId ?? "",
                            deckId: deckId,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          /// STATS TAB
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stats',
                builder: (context, state) => const StatsPage(),
              ),
            ],
          ),

          /// SETTINGS TAB
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      // :deckId
      GoRoute(
        path: '/study/session/:folderId/:deckId',
        builder: (context, state) {
          final deckId = state.pathParameters['deckId'];
          final folderId = state.pathParameters['folderId'];
          return FlashcardsSession(
            deckId: deckId ?? "",
            folderId: folderId ?? "",
          );
        },
      ),
    ],
  );
}
