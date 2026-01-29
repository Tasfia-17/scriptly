import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../openai/openai_config.dart';
import '../widgets/backgrounds.dart';

class IdeaOutlinePage extends StatefulWidget {
  const IdeaOutlinePage({super.key});
  @override State<IdeaOutlinePage> createState() => _IdeaOutlinePageState();
}

class _IdeaOutlinePageState extends State<IdeaOutlinePage> {
  final ideaCtrl = TextEditingController();
  final sections = <String>[];
  bool loading = false;

  Future<void> _expandWithAI() async {
    setState(() => loading = true);
    final app = context.read<AppState>();
    final client = OpenAIClient(overrideKey: app.openAIApiKeyOverride);
    try {
      final text = await client.chatText(
        system: 'You are a creative story outliner. Respond with 5 concise section titles followed by a 1-2 sentence description for each.',
        user: 'Story idea: ${ideaCtrl.text}',
      );
      final lines = text.split('\n').where((e) => e.trim().isNotEmpty).toList();
      setState(() {
        sections
          ..clear()
          ..addAll(lines.take(10));
      });
    } catch (e) {
      debugPrint('AI error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to contact AI.')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Idea & Outline')),
      body: BackgroundDecor(
        style: BackgroundStyle.forest,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              TextField(controller: ideaCtrl, decoration: const InputDecoration(hintText: 'A shy librarian discovers a map…')),
              const SizedBox(height: 10),
              ElevatedButton.icon(onPressed: loading ? null : _expandWithAI, icon: const Icon(Icons.auto_awesome, color: Colors.white), label: const Text('Expand Idea with AI', style: TextStyle(color: Colors.white))),
              const SizedBox(height: 10),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: sections.length,
                  onReorder: (o, n) { setState(() { final item = sections.removeAt(o); sections.insert(n > o ? n-1 : n, item); }); },
                  itemBuilder: (context, index) {
                    final ctrl = TextEditingController(text: sections[index]);
                    return Card(key: ValueKey('s$index'), child: Padding(padding: const EdgeInsets.all(12), child: TextField(controller: ctrl, maxLines: 3, onChanged: (v) => sections[index] = v)));
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
