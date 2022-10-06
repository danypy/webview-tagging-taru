import 'package:flutter/material.dart';
import 'package:taggingtaru/homepage.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

double skalaFont(double lebar) {
  if (lebar < 350) {
    return 0.7;
  } else if (lebar < 450) {
    return 0.9;
  }
  return 1.0;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'FontPoppins',
      ),
      home: const SafeArea(child: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int durasiSplashScreen = 3;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: durasiSplashScreen),
      navigationPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: skalaFont(query.size.width),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Container(
                height: 16,
              ),
              const Text('Loading'),
            ],
          ),
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Homepage(),
      ),
    );
  }
}
