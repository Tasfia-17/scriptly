import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../nav.dart';
import '../widgets/backgrounds.dart';
import '../widgets/icon_bubble.dart';
import '../widgets/guide_overlay.dart';
import '../widgets/logo.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key});
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final items = [
      (Icons.lightbulb, AppRoutes.idea),
      (Icons.edit, AppRoutes.script),
      (Icons.view_module, AppRoutes.scenes),
      (Icons.image, AppRoutes.storyboard),
      (Icons.graphic_eq, AppRoutes.audio),
      (Icons.chat_bubble, AppRoutes.chat),
      (Icons.person, AppRoutes.profile),
      (Icons.settings, AppRoutes.settings),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const ScriptlyLogo(size: 36),
        actions: const [],
      ),
      body: BackgroundDecor(
        style: BackgroundStyle.clouds,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: LayoutBuilder(builder: (context, c) {
                  final r = Random(7);
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      spacing: 22,
                      runSpacing: 22,
                      children: List.generate(items.length, (i) {
                        final dx = (r.nextDouble() - 0.5) * 10;
                        final dy = (r.nextDouble() - 0.5) * 10;
                        final pair = items[i];
                        final colors = [
                          Color.lerp(const Color(0xFFBEE3FF), const Color(0xFFA3F7E6), i / items.length)!,
                          Color.lerp(const Color(0xFF7DC8FF), const Color(0xFF7AD7C4), i / items.length)!,
                        ];
                        return Transform.translate(
                          offset: Offset(dx, dy),
                          child: IconBubble(
                            icon: pair.$1,
                            colors: colors,
                            onTap: () => context.push(pair.$2),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),
              if (app.guideEnabled)
                GuideOverlay(
                  text: 'Tap an icon to start your creative flow. You can turn this guide off in Settings.',
                  onClose: () => app.setGuideEnabled(false),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
