import 'package:flutter/material.dart';

void main() {
  runApp(const V2GApp());
}

class V2GApp extends StatelessWidget {
  const V2GApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V2G App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isV2GEnabled = false; // Toggle state for V2G

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V2G Features'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle for V2G functionality
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'V2G Enabled:',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: isV2GEnabled,
                  onChanged: (value) {
                    setState(() {
                      isV2GEnabled = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Navigation buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryScreen()));
              },
              child: const Text('View History'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GridPricesScreen()));
              },
              child: const Text('View Grid Prices'),
            ),
            const SizedBox(height: 20),
            // Other feature buttons
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen())),
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
              child: const Text('Login'),
            ),
            // ... Add more buttons for other features as needed
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: const Center(child: Text('Register UI')),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Login UI')),
    );
  }
}

class TokenRefreshScreen extends StatelessWidget {
  const TokenRefreshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Token Refresh')),
      body: const Center(child: Text('Token Refresh UI')),
    );
  }
}

class TokenRevokeScreen extends StatelessWidget {
  const TokenRevokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Token Revoke')),
      body: const Center(child: Text('Token Revoke UI')),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: const Center(child: Text('History UI')),
    );
  }
}

class GridPricesScreen extends StatelessWidget {
  const GridPricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid Prices')),
      body: const Center(child: Text('Grid Prices UI')),
    );
  }
}

// ... Add more screens for each feature as needed ... 