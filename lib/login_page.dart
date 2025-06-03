import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'database_helper.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = FlutterSecureStorage();
  final dbHelper = DatabaseHelper();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Войти'),
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final user = await dbHelper.getUser(email);

                if (user != null && user['password'] == password) {
                  await _storage.write(key: 'is_logged_in', value: 'true');

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Неверный email или пароль')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
