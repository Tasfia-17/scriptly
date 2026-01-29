import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../openai/openai_config.dart';
import '../widgets/backgrounds.dart';

class ScriptEditorPage extends StatefulWidget {
  const ScriptEditorPage({super.key});
  @override State<ScriptEditorPage> createState() => _ScriptEditorPageState();
}

class _ScriptEditorPageState extends State<ScriptEditorPage> {
  final scriptCtrl = TextEditingController();
  final versions = <String>[];
  bool loading = false;
  String? currentVersion;

  Future<void> _generateScript() async {
    setState(() => loading = true);
    final app = context.read<AppState>();
    final client = OpenAIClient(overrideKey: app.openAIApiKeyOverride);
    try {
      final text = await client.chatText(
        system: 'You are a screenplay writer. Produce a short scene in screenplay format, keep it concise.',
        user: scriptCtrl.text.isEmpty ? 'Write a short opening scene for a cozy mystery about a librarian who finds a map.' : scriptCtrl.text,
      );
      scriptCtrl.text = text;
    } catch (e) {
      debugPrint('AI error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Script generation failed.')));
    } finally {
      setState(() => loading = false);
    }
  }

  void _saveRevision() {
    setState(() {
      versions.insert(0, scriptCtrl.text);
      currentVersion = 'v${versions.length}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Script Editor')),
      body: BackgroundDecor(
        style: BackgroundStyle.clouds,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              ElevatedButton.icon(onPressed: loading ? null : _generateScript, icon: const Icon(Icons.flash_on, color: Colors.white), label: const Text('Generate Script', style: TextStyle(color: Colors.white))),
              const SizedBox(width: 8),
              if (versions.isNotEmpty)
                DropdownButton<String>(
                  hint: const Text('Version history'),
                  value: null,
                  items: versions.asMap().entries.map((e) => DropdownMenuItem<String>(value: 'v${e.key+1}', child: Text('v${e.key+1}'))).toList(),
                  onChanged: (v) { if (v == null) return; final idx = int.parse(v.substring(1)) - 1; setState(() => scriptCtrl.text = versions[idx]); },
                ),
              const Spacer(),
              ElevatedButton.icon(onPressed: _saveRevision, icon: const Icon(Icons.save, color: Colors.white), label: const Text('Save Revision', style: TextStyle(color: Colors.white))),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: scriptCtrl,
                expands: true,
                maxLines: null,
                minLines: null,
                style: const TextStyle(height: 1.5),
                decoration: const InputDecoration(hintText: 'Write or paste your script here…'),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
