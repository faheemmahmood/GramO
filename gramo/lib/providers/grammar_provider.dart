import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GrammarProvider extends ChangeNotifier {
  bool isLoading = false;
  String? suggestion;

  Future<void> checkGrammar(String text) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/grammar/check'), // replace with your backend URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        suggestion = data['suggestion'];
      } else {
        suggestion = 'Failed to fetch suggestions.';
      }
    } catch (e) {
      suggestion = 'An error occurred: $e';
    }

    isLoading = false;
    notifyListeners();
  }
}
