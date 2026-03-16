import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String languageCode = 'en';

  void toggleLanguage() {
    setState(() {
      languageCode = languageCode == 'en' ? 'hi' : 'en';
    });
  }

  void _goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          languageCode: languageCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Restaurant Logo
              Image.network(
                'https://gimgs2.nohat.cc/thumb/f/640/restaurant-clipart-spoon-fork-crossed-spoon-and-fork-logo-png--m2i8i8d3G6d3K9Z5.jpg',
                height: 120,
                errorBuilder: (_, __, ___) => const Icon(Icons.restaurant, size: 100),
              ),
              const SizedBox(height: 30),
              Text(
                languageCode == 'en' ? 'Welcome' : 'आपका स्वागत है',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _goToHomeScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                ),
                child: Text(
                  languageCode == 'en' ? 'Continue' : 'जारी रखें',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: toggleLanguage,
                child: Text(
                  languageCode == 'en' ? 'Switch to Hindi' : 'अंग्रेज़ी में बदलें',
                  style: const TextStyle(color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
