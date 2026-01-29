import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_state.dart';
import 'pages/onboarding_page.dart';
import 'pages/home_main.dart';
import 'pages/idea_outline_page.dart';
import 'pages/script_editor_page.dart';
import 'pages/scene_manager_page.dart';
import 'pages/storyboard_page.dart';
import 'pages/audio_page.dart';
import 'pages/chat_assistant_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';

class AppRouter {
  static GoRouter buildRouter(AppState app) => GoRouter(
        initialLocation: AppRoutes.splash,
        refreshListenable: app,
        redirect: (context, state) {
          if (!app.isLoaded) return null;
          if (!app.onboardingDone && state.fullPath != AppRoutes.onboarding) {
            return AppRoutes.onboarding;
          }
          if (app.onboardingDone && state.fullPath == AppRoutes.splash) {
            return AppRoutes.home;
          }
          return null;
        },
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            pageBuilder: (context, state) => const NoTransitionPage(child: _Splash()),
          ),
          GoRoute(
            path: AppRoutes.onboarding,
            pageBuilder: (context, state) => const NoTransitionPage(child: OnboardingPage()),
          ),
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(child: HomeMainPage()),
          ),
          GoRoute(path: AppRoutes.idea, builder: (c, s) => const IdeaOutlinePage()),
          GoRoute(path: AppRoutes.script, builder: (c, s) => const ScriptEditorPage()),
          GoRoute(path: AppRoutes.scenes, builder: (c, s) => const SceneManagerPage()),
          GoRoute(path: AppRoutes.storyboard, builder: (c, s) => const StoryboardPage()),
          GoRoute(path: AppRoutes.audio, builder: (c, s) => const AudioPage()),
          GoRoute(path: AppRoutes.chat, builder: (c, s) => const ChatAssistantPage()),
          GoRoute(path: AppRoutes.profile, builder: (c, s) => const ProfilePage()),
          GoRoute(path: AppRoutes.settings, builder: (c, s) => const SettingsPage()),
        ],
      );
}

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String idea = '/idea';
  static const String script = '/script';
  static const String scenes = '/scenes';
  static const String storyboard = '/storyboard';
  static const String audio = '/audio';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

class _Splash extends StatelessWidget {
  const _Splash();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text('Loading Scriptly…', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
