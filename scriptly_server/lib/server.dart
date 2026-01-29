import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_postgres/serverpod_postgres.dart';
import 'package:serverpod_redis/serverpod_redis.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: ServerpodAuthHandler(),
  );

  pod.webServer.addRoute(
    RouteRoot(),
    '/',
  );

  await pod.start();
}

class RouteRoot extends WidgetRoute {
  @override
  Widget build(BuildContext context) => const ScriptlyWebApp();
}

class ScriptlyWebApp extends StatelessWidget {
  const ScriptlyWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scriptly Admin',
      home: Scaffold(
        appBar: AppBar(title: const Text('Scriptly Backend')),
        body: const Center(
          child: Text('Scriptly Serverpod Backend Running'),
        ),
      ),
    );
  }
}
