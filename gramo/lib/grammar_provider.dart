import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class GrammarProvider extends ChangeNotifier {
  bool isLoading = false;
  String? suggestion;

  Future<void> checkGrammar(String text) async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await AuthService.getToken();
      final response = await http.post(
        Uri.parse('https://gramo-production.up.railway.app/api/grammar/check'), // Correct URL for your backend
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
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
