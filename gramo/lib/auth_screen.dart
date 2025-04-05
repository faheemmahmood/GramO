import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'grammar_check_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLogin = true;
  String? _error;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String? result;

      if (_isLogin) {
        result = await AuthService.login(_username, _password);
      } else {
        result = await AuthService.signup(_username, _password);
      }

      if (result == null) {
        if (_isLogin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => GrammarCheckScreen()),
          );
        } else {
          setState(() {
            _isLogin = true;
            _error = 'Signup successful. Please log in.';
          });
        }
      } else {
        setState(() => _error = result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(  // Added to avoid overflow on small screens
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // Centers content vertically
              crossAxisAlignment: CrossAxisAlignment.center,  // Centers content horizontally
              children: [
                if (_error != null)
                  Text(_error!, style: TextStyle(color: Colors.red)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Username'),
                        onSaved: (val) => _username = val!,
                        validator: (val) => val!.isEmpty ? 'Enter username' : null,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        onSaved: (val) => _password = val!,
                        validator: (val) => val!.isEmpty ? 'Enter password' : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin ? 'Need an account? Sign Up' : 'Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
