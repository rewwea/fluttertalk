import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'welcome_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _storage = FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: 'is_logged_in');
    return value == 'true';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMessenger',
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return snapshot.data! ? HomePage() : const WelcomePage();
        },
      ),
    );
  }
}