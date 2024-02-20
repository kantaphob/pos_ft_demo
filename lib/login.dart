import 'package:flutter/material.dart';
import 'package:pos_ft_demo/ShoppingCart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = ' ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<Map<String, String>> _users = [
    {'username': 'admin', 'password': '1234'},
    {'username': '64143109', 'password': '1234'},
    {'username': '64143151', 'password': '1234'},
    {'username': '64143203', 'password': '1234'}
  ];
  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Icon(
                  Icons.local_cafe,
                  size: 50,
                  color: Colors.brown,
                ),
                Text(
                  'COMMIT Cafe',
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sign in',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  _login();
                },
              ),
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red), // Set font color to red
              ),
            ),
        ],
      ),
    );
  }

  void _login() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final bool isValidUser = _users.any(
      (user) => user['username'] == username && user['password'] == password,
    );

    if (isValidUser) {
      // Navigate to Menu
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShoppingCart()),
      );
    } else {
      setState(() {
        _errorMessage = 'Username or Password is incorrect';
      });
    }
  }
}
//20/2/67/23.41