import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

class ScriptlyClient {
  static late Client _client;
  static late SessionManager _sessionManager;

  static void initialize({
    required String serverUrl,
  }) {
    _client = Client(
      serverUrl,
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    );
    _sessionManager = SessionManager(caller: _client.modules.auth);
  }

  static Client get client => _client;
  static SessionManager get sessionManager => _sessionManager;

  // Project methods
  static Future<List<Project>> getUserProjects(int userId) async {
    return await _client.project.getUserProjects(userId);
  }

  static Future<Project> createProject(Project project) async {
    return await _client.project.createProject(project);
  }

  static Future<Project?> updateProject(Project project) async {
    return await _client.project.updateProject(project);
  }

  static Future<bool> deleteProject(int projectId) async {
    return await _client.project.deleteProject(projectId);
  }

  // Scene methods
  static Future<List<Scene>> getProjectScenes(int projectId) async {
    return await _client.scene.getProjectScenes(projectId);
  }

  static Future<Scene> createScene(Scene scene) async {
    return await _client.scene.createScene(scene);
  }

  static Future<Scene?> updateScene(Scene scene) async {
    return await _client.scene.updateScene(scene);
  }

  static Future<bool> deleteScene(int sceneId) async {
    return await _client.scene.deleteScene(sceneId);
  }

  static Future<List<Scene>> reorderScenes(List<Scene> scenes) async {
    return await _client.scene.reorderScenes(scenes);
  }

  // Script methods
  static Future<List<Script>> getProjectScripts(int projectId) async {
    return await _client.script.getProjectScripts(projectId);
  }

  static Future<Script> saveScript(Script script) async {
    return await _client.script.saveScript(script);
  }

  static Future<Script?> getLatestScript(int projectId) async {
    return await _client.script.getLatestScript(projectId);
  }

  // AI methods
  static Future<String> generateOutline(String idea) async {
    return await _client.ai.generateOutline(idea);
  }

  static Future<String> generateScript(String prompt) async {
    return await _client.ai.generateScript(prompt);
  }

  static Future<String> chatAssistant(String message, int userId) async {
    return await _client.ai.chatAssistant(message, userId);
  }

  // User methods
  static Future<User?> getUserByEmail(String email) async {
    return await _client.user.getUserByEmail(email);
  }

  static Future<User> createUser(User user) async {
    return await _client.user.createUser(user);
  }

  static Future<User?> updateUser(User user) async {
    return await _client.user.updateUser(user);
  }
}
