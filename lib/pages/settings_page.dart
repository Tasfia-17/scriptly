import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../widgets/backgrounds.dart';
import 'package:go_router/go_router.dart';
import '../nav.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final openaiCtrl = TextEditingController(text: app.openAIApiKeyOverride ?? '');
    final geminiCtrl = TextEditingController(text: app.geminiApiKey ?? '');
    final elevenCtrl = TextEditingController(text: app.elevenLabsApiKey ?? '');
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BackgroundDecor(
        style: BackgroundStyle.pastel,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Preferences', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Show guide'),
              value: app.guideEnabled,
              onChanged: (v) => app.setGuideEnabled(v),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Replay onboarding'),
              subtitle: const Text('Show the welcome screens again'),
              trailing: ElevatedButton.icon(
                onPressed: () async {
                  await app.resetOnboarding();
                  if (context.mounted) context.go(AppRoutes.onboarding);
                },
                icon: const Icon(Icons.replay, color: Colors.white),
                label: const Text('Replay', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            Text('Bring your own API keys', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            _ApiField(label: 'OpenAI', controller: openaiCtrl, hint: 'sk-...'),
            _ApiField(label: 'Gemini', controller: geminiCtrl, hint: 'AIz...'),
            _ApiField(label: 'ElevenLabs', controller: elevenCtrl, hint: 'eleven-...'),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => app.setApiKeys(openai: openaiCtrl.text, gemini: geminiCtrl.text, eleven: elevenCtrl.text),
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiField extends StatelessWidget {
  final String label; final TextEditingController controller; final String hint;
  const _ApiField({required this.label, required this.controller, required this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, hintText: hint),
        obscureText: true,
      ),
    );
  }
}
