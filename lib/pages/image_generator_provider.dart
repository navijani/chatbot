import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIProvider extends ChangeNotifier {
  String? response;
  bool isLoading = false;

  Future<void> fetchAIResponse(String enteredText) async {
    final apiUrl = 'https://api.x.ai/v1/chat/completions';
    final apiKey = dotenv.env['XAI_API_KEY'];

    if (apiKey == null) {
      throw Exception('API Key not found in .env file');
    }

    isLoading = true;
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "messages": [
            {
              "role": "system",
              "content": enteredText,
            },
            
          ],
          "model": "grok-beta",
          "stream": false,
          "temperature": 0
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        response = data['choices'][0]['message']['content']; // Adjust if API response structure differs
      } else {
        response = 'Error: ${res.statusCode} - ${res.body}';
      }
    } catch (e) {
      response = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
