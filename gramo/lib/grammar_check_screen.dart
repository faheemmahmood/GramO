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
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () => provider.checkGrammar(_controller.text),
              child: provider.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Check Grammar'),
            ),
            const SizedBox(height: 20),
            if (provider.suggestion != null)
              Text(
                'Suggestion:\n${provider.suggestion!}',
                style: TextStyle(fontSize: 16, color: Colors.greenAccent),
              ),
          ],
        ),
      ),
    );
  }
}
