import 'package:flutter/material.dart';

void main() {
  runApp(V2GApp());
}

class V2GApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V2G App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('V2G Features'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Register'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
          ),
          ListTile(
            title: Text('Login'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
          ),
          ListTile(
            title: Text('Token Refresh'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TokenRefreshScreen())),
          ),
          ListTile(
            title: Text('Token Revoke'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TokenRevokeScreen())),
          ),
          // ... Add more ListTiles for each API endpoint
        ],
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(child: Text('Register UI')),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(child: Text('Login UI')),
    );
  }
}

class TokenRefreshScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Token Refresh')),
      body: Center(child: Text('Token Refresh UI')),
    );
  }
}

class TokenRevokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Token Revoke')),
      body: Center(child: Text('Token Revoke UI')),
    );
  }
}

// ... Add more screens for each feature as needed ... 