import 'package:flutter/material.dart';
import '../widgets/backgrounds.dart';

class StoryboardPage extends StatefulWidget {
  const StoryboardPage({super.key});
  @override State<StoryboardPage> createState() => _StoryboardPageState();
}

class _StoryboardPageState extends State<StoryboardPage> {
  String style = 'Cinematic';
  final scenes = List.generate(6, (i) => 'Scene ${i+1}');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storyboard')),
      body: BackgroundDecor(
        style: BackgroundStyle.deepSea,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              const Text('Style:'),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: style,
                items: const [DropdownMenuItem(value: 'Cinematic', child: Text('Cinematic')), DropdownMenuItem(value: 'Kids', child: Text('Kids')), DropdownMenuItem(value: 'Documentary', child: Text('Documentary'))],
                onChanged: (v) => setState(() => style = v ?? 'Cinematic'),
              ),
              const Spacer(),
              ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.brush, color: Colors.white), label: const Text('Generate Storyboard Images', style: TextStyle(color: Colors.white))),
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.2),
                itemCount: scenes.length,
                itemBuilder: (context, i) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(children: [
                    Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFFBEE3FF), const Color(0xFFA9E3D7)])))),
                    const Positioned.fill(child: Icon(Icons.image, size: 60, color: Colors.white70)),
                    Positioned(left: 8, top: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(12)), child: Text(scenes[i], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))))
                  ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
