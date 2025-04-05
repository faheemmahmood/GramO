import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grammar_provider.dart';
import 'auth_service.dart';
import 'auth_screen.dart';
import 'grammar_check_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkAuth() => AuthService.isLoggedIn();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GrammarProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GramO',
        theme: ThemeData.dark(),
        home: FutureBuilder<bool>(
          future: checkAuth(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            return snapshot.data == true ? GrammarCheckScreen() : AuthScreen();
          },
        ),
      ),
    );
  }
}
