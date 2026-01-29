import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../nav.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  String name = '';
  String email = '';

  final images = const [
    'assets/images/onboarding01.webp',
    'assets/images/onboarding02.webp',
    'assets/images/onboarding03.png',
    'assets/images/onboarding04.webp',
  ];

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Stack(children: [
                Positioned.fill(
                  child: Image.asset(images[index], fit: BoxFit.cover),
                ),
                Positioned(
                  left: 16, right: 16, bottom: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        switch (index) {
                          0 => 'Welcome to Scriptly',
                          1 => 'Dream up outlines',
                          2 => 'Turn ideas into scripts',
                          _ => 'Bring words to life',
                        },
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'From idea to script, visuals, and voice in one flow',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                if (index == 3) _buildSignup(context, app),
              ]);
            },
          ),
          Positioned(
            top: 40, right: 16,
            child: TextButton(
              onPressed: () async {
                await app.completeOnboarding();
                if (context.mounted) context.go(AppRoutes.home);
              },
              child: const Text('Skip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignup(BuildContext context, AppState app) {
    return Positioned(
      left: 16, right: 16, bottom: 24,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.92), borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Create your studio', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: TextField(decoration: const InputDecoration(hintText: 'Your name'), onChanged: (v) => name = v)),
            const SizedBox(width: 8),
            Expanded(child: TextField(decoration: const InputDecoration(hintText: 'Email (optional)'), onChanged: (v) => email = v)),
          ]),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              await app.completeOnboarding();
              if (context.mounted) context.go(AppRoutes.home);
            },
            icon: const Icon(Icons.bolt, color: Colors.white),
            label: const Text('Get started', style: TextStyle(color: Colors.white)),
          )
        ]),
      ),
    );
  }
}
