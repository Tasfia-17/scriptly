import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'nav.dart';
import 'app_state.dart';
import 'package:scriptly_client/scriptly_client.dart';

void main() {
  // Initialize Serverpod client
  ScriptlyClient.initialize(
    serverUrl: 'http://localhost:8080/',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()..initialize()),
      ],
      child: Consumer<AppState>(
        builder: (context, app, _) => MaterialApp.router(
          title: 'Scriptly',
          debugShowCheckedModeBanner: false,
          theme: buildLightTheme(app),
          routerConfig: AppRouter.buildRouter(app),
        ),
      ),
    );
  }
}
