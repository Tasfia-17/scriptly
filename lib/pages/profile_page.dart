import 'package:flutter/material.dart';
import '../widgets/backgrounds.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final recent = List.generate(5, (i) => 'Project ${i+1}');
    final favorites = ['Kids Story', 'Documentary', 'Mystery'];
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: BackgroundDecor(
        style: BackgroundStyle.forest,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Scriptly', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text('All-in-one AI storytelling workflow', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.add, color: Colors.white), label: const Text('Create New Project', style: TextStyle(color: Colors.white))),
            const SizedBox(height: 20),
            Text('Recent projects', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            ...recent.map((p) => Card(child: ListTile(title: Text(p), trailing: const Icon(Icons.chevron_right)))).toList(),
            const SizedBox(height: 20),
            Text('Favorite templates', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: favorites.map((f) => Chip(label: Text(f))).toList()),
            const SizedBox(height: 20),
            Card(child: ListTile(leading: const Icon(Icons.stars, color: Colors.amber), title: const Text('Level 3 • Story Artisan'), subtitle: const Text('Write 2 more scripts to reach Level 4'))),
          ],
        ),
      ),
    );
  }
}
