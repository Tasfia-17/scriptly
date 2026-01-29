import 'package:flutter/material.dart';
import '../widgets/backgrounds.dart';

class SceneManagerPage extends StatefulWidget {
  const SceneManagerPage({super.key});
  @override State<SceneManagerPage> createState() => _SceneManagerPageState();
}

class _SceneManagerPageState extends State<SceneManagerPage> {
  final scenes = <_Scene>[
    _Scene('Opening', '00:45'),
    _Scene('Discovery', '01:10'),
    _Scene('Decision', '00:55'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scene Manager')),
      body: BackgroundDecor(
        style: BackgroundStyle.pastel,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ReorderableListView.builder(
            itemCount: scenes.length,
            onReorder: (o, n) => setState(() { final s = scenes.removeAt(o); scenes.insert(n>o? n-1 : n, s); }),
            itemBuilder: (context, i) {
              final sc = scenes[i];
              return Card(key: ValueKey('scene$i'), child: ListTile(
                title: Text(sc.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('Duration: ${sc.duration}  •  Status: ${sc.locked ? 'Locked' : 'Editable'}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: sc.locked ? null : () async {
                    final newTitle = await showDialog<String>(context: context, builder: (c) {
                      final ctrl = TextEditingController(text: sc.title);
                      return AlertDialog(title: const Text('Edit scene title'), content: TextField(controller: ctrl), actions: [TextButton(onPressed: ()=> Navigator.pop(c), child: const Text('Cancel')), TextButton(onPressed: ()=> Navigator.pop(c, ctrl.text), child: const Text('Save'))]);
                    });
                    if (newTitle != null) setState(() => sc.title = newTitle);
                  }),
                  IconButton(icon: Icon(sc.locked ? Icons.lock : Icons.lock_open), onPressed: () => setState(() => sc.locked = !sc.locked)),
                ]),
              ));
            },
          ),
        ),
      ),
    );
  }
}

class _Scene { String title; String duration; bool locked; _Scene(this.title, this.duration, {this.locked = false}); }
