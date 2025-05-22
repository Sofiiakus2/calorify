import 'dart:convert';

import 'package:calorify/features/ai_functional/data/datasources/remote/remote_ai_data_source.dart';
import 'package:http/http.dart' as http;

class RemoteAiDataSourceImpl implements RemoteAiDataSource{

  @override
  Future<String?> analyzeImageWithGemini(String base64Image) async {
    final apiKey = 'AIzaSyAC5_56ANCWwMVAe1womkCe0NwQaAGfg9U';
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": "Describe the products in the photo. Name, approximate weight, and total calories, proteins, fats, and carbohydrates of all products together. Give the answer in json format {products{[name, weight, caloriesTotal, proteinsTotal, fatsTotal, carbohydratedTotal]}, totals{totalCalories, totalProteins, totalFats, totalCarbohydrates}} - your response should start with '{' -filled json '}' no extra characters. weight is String type with unit. json in English but its value in Ukrainian"},
              {
                "inlineData": {
                  "mimeType": "image/jpeg",
                  "data": base64Image
                }
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body as String);
      final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      printLongText(text as String);

      return text as String;
    } else {
      print('Gemini error: ${response.body}');

      return null;
    }
  }

  void printLongText(String text) {
    const int chunkSize = 800;
    for (int i = 0; i < text.length; i += chunkSize) {
      int endIndex = (i + chunkSize < text.length) ? i + chunkSize : text.length;
      print(text.substring(i, endIndex));
    }
  }

}