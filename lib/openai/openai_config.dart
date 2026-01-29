import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIClient {
  final String? overrideKey;
  
  OpenAIClient({this.overrideKey});

  Future<String> chatText({
    required String system,
    required String user,
  }) async {
    final apiKey = overrideKey ?? 'your-default-api-key';
    
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': system},
          {'role': 'user', 'content': user},
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get AI response: ${response.statusCode}');
    }
  }
}
