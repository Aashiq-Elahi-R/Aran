

import 'package:flutter/material.dart';
import 'fake_call_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent, // 💖 Women's theme
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins', // ✨ More elegant font (optional, if installed)
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  void triggerFakeCall(BuildContext context) {
    String callerName = _nameController.text.trim().isNotEmpty
        ? _nameController.text.trim()
        : "Unknown Caller";

    Future.delayed(const Duration(seconds: 5), () {
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FakeCallScreen(
            callerName: callerName,
            callerImage: "assets/CallerIcon.png",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fake Call for Safety",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 6,
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Caller Name",
                      hintText: "Enter a safe contact...",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.female, color: Colors.pinkAccent),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => triggerFakeCall(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.phone_in_talk_rounded, size: 26),
                  label: const Text(
                    "Schedule Fake Call",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
