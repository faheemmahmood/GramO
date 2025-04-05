import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grammar_provider.dart';
import 'auth_service.dart';
import 'auth_screen.dart';

class GrammarCheckScreen extends StatefulWidget {
  @override
  _GrammarCheckScreenState createState() => _GrammarCheckScreenState();
}

class _GrammarCheckScreenState extends State<GrammarCheckScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  bool _hasError = false; // Track if there's an error

  void _logout() async {
    await AuthService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GrammarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grammar Checker'),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Output field
            TextField(
              controller: _outputController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Output',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: _hasError ? const Color.fromARGB(255, 26, 24, 24) : const Color.fromARGB(255, 45, 48, 45), // Color based on error
              ),
              readOnly: true, // Ensures the user cannot edit the output field
              style: TextStyle(
                color: _hasError ? Colors.red : Colors.green,
                decoration: _hasError ? TextDecoration.underline : TextDecoration.none, // Underline if there's an error
              ),
            ),
            const SizedBox(height: 20),

            // User input field
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Check Grammar Button
            ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () {
                      provider.checkGrammar(_controller.text).then((_) {
                        final suggestion = provider.suggestion ?? '';
                        setState(() {
                          if (suggestion.isEmpty) {
                            _hasError = false; // No mistakes
                            _outputController.text = 'No mistakes';
                          } else {
                            _hasError = true; // Errors found
                            _outputController.text = suggestion;
                          }
                        });
                      });
                    },
              child: provider.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Check Grammar'),
            ),
          ],
        ),
      ),
    );
  }
}

