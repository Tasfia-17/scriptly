import 'package:serverpod/serverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../generated/protocol.dart';

class AIEndpoint extends Endpoint {
  Future&lt;String&gt; generateOutline(Session session, String idea) async {
    final apiKey = session.serverpod.getPassword('openai_api_key');
    if (apiKey == null) throw Exception('OpenAI API key not configured');

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a creative story outliner. Create 5 detailed sections with titles and descriptions.'
          },
          {'role': 'user', 'content': 'Story idea: $idea'}
        ],
        'max_tokens': 1000,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    }
    throw Exception('AI request failed: ${response.statusCode}');
  }

  Future&lt;String&gt; generateScript(Session session, String prompt) async {
    final apiKey = session.serverpod.getPassword('openai_api_key');
    if (apiKey == null) throw Exception('OpenAI API key not configured');

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a professional screenplay writer. Write in proper screenplay format.'
          },
          {'role': 'user', 'content': prompt}
        ],
        'max_tokens': 1500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    }
    throw Exception('AI request failed: ${response.statusCode}');
  }

  Future&lt;String&gt; chatAssistant(Session session, String message, int userId) async {
    // Save user message
    await ChatMessage.db.insertRow(
      session,
      ChatMessage(
        role: 'user',
        content: message,
        userId: userId,
      ),
    );

    final apiKey = session.serverpod.getPassword('openai_api_key');
    if (apiKey == null) throw Exception('OpenAI API key not configured');

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a helpful creative writing assistant. Keep responses concise and encouraging.'
          },
          {'role': 'user', 'content': message}
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      
      // Save assistant response
      await ChatMessage.db.insertRow(
        session,
        ChatMessage(
          role: 'assistant',
          content: reply,
          userId: userId,
        ),
      );
      
      return reply;
    }
    throw Exception('AI request failed: ${response.statusCode}');
  }
}
