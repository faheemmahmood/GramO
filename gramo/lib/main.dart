import 'package:flutter/material.dart';
import 'providers/grammar_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GrammarProvider(),
      child: MaterialApp(
        title: 'Grammar Checker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GrammarCheckerScreen(),
      ),
    );
  }
}

class GrammarCheckerScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grammar Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter text to check grammar',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  // Trigger grammar check
                  context.read<GrammarProvider>().checkGrammar(_controller.text);
                }
              },
              child: Text('Check Grammar'),
            ),
            SizedBox(height: 20),
            Consumer<GrammarProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return CircularProgressIndicator();
                }
                if (provider.suggestion != null) {
                  return Text(
                    provider.suggestion!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
