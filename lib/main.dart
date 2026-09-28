import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/app_shell.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';

void main() {
  runApp(const RecipesApp());
}

class RecipesApp extends StatefulWidget {
  const RecipesApp({super.key});

  @override
  State<RecipesApp> createState() => _RecipesAppState();
}

class _RecipesAppState extends State<RecipesApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      // Shell route wraps home, add & settings with NavigationBar
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/add',
            name: 'add',
            builder: (context, state) => const AddRecipeScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) =>
                SettingsScreen(themeNotifier: _themeNotifier),
          ),
        ],
      ),
      // Detail route is outside shell (full screen, no NavigationBar)
      GoRoute(
        path: '/recipe/:id',
        name: 'recipeDetail',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RecipeDetailScreen(recipeId: id);
        },
      ),
    ],
  );

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeNotifier,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Cuisine Ivoirienne',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeNotifier.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
