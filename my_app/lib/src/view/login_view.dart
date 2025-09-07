import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/src/data/request/login_request.dart';
import 'package:my_app/src/models/user_model.dart';
import 'package:my_app/src/provider/user_provider.dart';
import 'package:my_app/src/widgets/button_widget.dart';
import 'package:my_app/src/widgets/text_field_widget.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/src/widgets/theme_slider_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      final loginRequest = LoginRequest(username: email, password: password);

      try {
        print('Email: $email');
        print('Password: $password');

        final response = await http.post(
          Uri.parse('http://localhost:3000/users/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginRequest.toJson()),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          print('🍰 Login response: $responseData');

          final user = User.fromJson(responseData);

          Provider.of<UserProvider>(context, listen: false).login(user);
          
          // Show welcome message from backend
          final welcomeMessage = responseData['message'] ?? 'Welcome to Sweet Dreams Bakery! 🍰';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(welcomeMessage),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Handle error response
          final errorData = jsonDecode(response.body);
          final errorMessage = errorData['error'] ?? 'Login failed';
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ $errorMessage'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                controller: _emailController,
                labelText: 'Username or Email',
                hintText: 'Enter your username or email',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username or email';
                  }
                  if (value.length < 3) {
                    return 'Username or email must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              CustomButton(
                text: 'Login',
                onPressed: () => _login(context),
              ),
              const SizedBox(height: 24.0),
              
              // Register Link
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'New to Sweet Dreams Bakery? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: 'Create Account',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
