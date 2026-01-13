import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/date_inputs.dart';
import '../models/date_plan.dart';

class OpenAIService {
  OpenAIService({http.Client? client}) : _client = client ?? http.Client();

  static const String _endpoint = 'https://api.openai.com/v1/chat/completions';
  static const String _model = 'gpt-4o-mini';
  final http.Client _client;

  Future<DatePlan> generatePlan(DateInputs inputs) async {
    final apiKey = const String.fromEnvironment('OPENAI_API_KEY');
    if (apiKey.isEmpty) {
      throw Exception(
        'Missing OPENAI_API_KEY. Pass it with --dart-define=OPENAI_API_KEY=your_key',
      );
    }

    final messages = <Map<String, String>>[
      {
        'role': 'system',
        'content':
            'You are a helpful first-date planning assistant. '
            'Return ONLY valid JSON with keys: '
            '{"outfit": string, "first_words": [string, string, string], '
            '"attitude": [string, string, string], "mistakes": [string, string, string], '
            '"timing": string}. '
            'Keep advice respectful, safe, practical, and non-manipulative. '
            'No explicit sexual content. No markdown. No extra text.',
      },
      {
        'role': 'user',
        'content':
            'Create a personalized first-date plan using these details: '
            '${jsonEncode(inputs.toJson())}',
      }
    ];

    final content = await _sendRequest(apiKey, messages);
    try {
      final decoded = _parseJson(content);
      return DatePlan.fromJson(decoded);
    } on FormatException {
      final fixed = await _sendRequest(
        apiKey,
        [
          {
            'role': 'system',
            'content':
                'Fix the JSON and return ONLY valid JSON with the required keys. '
                'No markdown. No extra text.',
          },
          {
            'role': 'user',
            'content': content,
          }
        ],
      );
      final decoded = _parseJson(fixed);
      return DatePlan.fromJson(decoded);
    }
  }

  Future<String> _sendRequest(
    String apiKey,
    List<Map<String, String>> messages,
  ) async {
    final response = await _client.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'messages': messages,
        'temperature': 0.7,
        'max_tokens': 500,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'OpenAI request failed: ${response.statusCode} ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = data['choices'] as List<dynamic>;
    if (choices.isEmpty) {
      throw Exception('OpenAI response missing choices.');
    }
    final message = choices.first['message'] as Map<String, dynamic>;
    final content = message['content'];
    if (content is! String) {
      throw Exception('OpenAI response content missing.');
    }
    return content.trim();
  }

  Map<String, dynamic> _parseJson(String content) {
    final decoded = jsonDecode(content);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw const FormatException('Invalid JSON format.');
  }
}
