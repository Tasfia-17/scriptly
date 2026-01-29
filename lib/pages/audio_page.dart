import 'package:flutter/material.dart';
import '../widgets/backgrounds.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});
  @override State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  String language = 'English';
  final voices = ['Narrator', 'Hero', 'Friend'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio & Audiobook')),
      body: BackgroundDecor(
        style: BackgroundStyle.pastel,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              const Text('Language:'), const SizedBox(width: 8),
              DropdownButton<String>(value: language, items: const [DropdownMenuItem(value: 'English', child: Text('English')), DropdownMenuItem(value: 'Spanish', child: Text('Spanish'))], onChanged: (v)=> setState(()=> language = v ?? 'English')),
              const Spacer(),
              ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.graphic_eq, color: Colors.white), label: const Text('Generate Audio', style: TextStyle(color: Colors.white))),
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) => Card(child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Scene ${i+1}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      DropdownButton<String>(value: voices.first, items: voices.map((e)=> DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (_){})
                    ])),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.play_arrow)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.stop)),
                  ]),
                )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
