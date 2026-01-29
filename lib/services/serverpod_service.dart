import 'package:flutter/material.dart';
import 'package:scriptly_client/scriptly_client.dart';

class ServerpodService {
  // Project operations
  static Future<List<Project>> getUserProjects(int userId) async {
    try {
      return await ScriptlyClient.getUserProjects(userId);
    } catch (e) {
      debugPrint('Error fetching projects: $e');
      return [];
    }
  }

  static Future<Project?> createProject({
    required String title,
    required String description,
    required int userId,
  }) async {
    try {
      final project = Project(
        title: title,
        description: description,
        userId: userId,
      );
      return await ScriptlyClient.createProject(project);
    } catch (e) {
      debugPrint('Error creating project: $e');
      return null;
    }
  }

  // Scene operations
  static Future<List<Scene>> getProjectScenes(int projectId) async {
    try {
      return await ScriptlyClient.getProjectScenes(projectId);
    } catch (e) {
      debugPrint('Error fetching scenes: $e');
      return [];
    }
  }

  static Future<Scene?> createScene({
    required String title,
    required int projectId,
    String? content,
    String? duration,
  }) async {
    try {
      final scene = Scene(
        title: title,
        content: content,
        duration: duration,
        projectId: projectId,
      );
      return await ScriptlyClient.createScene(scene);
    } catch (e) {
      debugPrint('Error creating scene: $e');
      return null;
    }
  }

  // Script operations
  static Future<Script?> saveScript({
    required String content,
    required int projectId,
    String version = 'v1',
  }) async {
    try {
      final script = Script(
        content: content,
        version: version,
        projectId: projectId,
      );
      return await ScriptlyClient.saveScript(script);
    } catch (e) {
      debugPrint('Error saving script: $e');
      return null;
    }
  }

  static Future<List<Script>> getProjectScripts(int projectId) async {
    try {
      return await ScriptlyClient.getProjectScripts(projectId);
    } catch (e) {
      debugPrint('Error fetching scripts: $e');
      return [];
    }
  }

  // AI operations
  static Future<String?> generateOutline(String idea) async {
    try {
      return await ScriptlyClient.generateOutline(idea);
    } catch (e) {
      debugPrint('Error generating outline: $e');
      return null;
    }
  }

  static Future<String?> generateScript(String prompt) async {
    try {
      return await ScriptlyClient.generateScript(prompt);
    } catch (e) {
      debugPrint('Error generating script: $e');
      return null;
    }
  }

  static Future<String?> chatAssistant(String message, int userId) async {
    try {
      return await ScriptlyClient.chatAssistant(message, userId);
    } catch (e) {
      debugPrint('Error in chat: $e');
      return null;
    }
  }

  // User operations
  static Future<User?> createUser({
    required String email,
    required String name,
  }) async {
    try {
      final user = User(
        email: email,
        name: name,
      );
      return await ScriptlyClient.createUser(user);
    } catch (e) {
      debugPrint('Error creating user: $e');
      return null;
    }
  }

  static Future<User?> getUserByEmail(String email) async {
    try {
      return await ScriptlyClient.getUserByEmail(email);
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }
}
