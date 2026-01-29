import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../openai/openai_config.dart';
import '../widgets/backgrounds.dart';

class ChatAssistantPage extends StatefulWidget {
  const ChatAssistantPage({super.key});
  @override State<ChatAssistantPage> createState() => _ChatAssistantPageState();
}

class _ChatAssistantPageState extends State<ChatAssistantPage> {
  final inputCtrl = TextEditingController();
  final messages = <_Msg>[];
  bool loading = false;

  Future<void> _send() async {
    final content = inputCtrl.text.trim();
    if (content.isEmpty) return;
    setState(() { inputCtrl.clear(); messages.add(_Msg(role: 'user', text: content)); loading = true; });
    final app = context.read<AppState>();
    final client = OpenAIClient(overrideKey: app.openAIApiKeyOverride);
    try {
      final reply = await client.chatText(
        system: 'You are a helpful creative writing assistant. Keep responses short and friendly.',
        user: content,
      );
      setState(() { messages.add(_Msg(role: 'assistant', text: reply)); });
    } catch (e) {
      debugPrint('Chat AI error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI request failed.')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chat Assistant')),
      body: BackgroundDecor(
        style: BackgroundStyle.waves,
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final m = messages[i];
                final align = m.role == 'user' ? Alignment.centerRight : Alignment.centerLeft;
                final bubbleColor = m.role == 'user' ? const Color(0xFF7DC8FF) : const Color(0xFFA3F7E6);
                return Align(
                  alignment: align,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(16)),
                    child: Text(m.text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(children: [
              Expanded(child: TextField(controller: inputCtrl, decoration: const InputDecoration(hintText: 'Ask for feedback or ideas…'))),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: loading ? null : _send, child: const Icon(Icons.send, color: Colors.white))
            ]),
          )
        ]),
      ),
    );
  }
}

class _Msg { final String role; final String text; _Msg({required this.role, required this.text}); }
