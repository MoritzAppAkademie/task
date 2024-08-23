import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.purple,
                child: Text(
                  "Willkommen zur Checkliste!",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                )),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.check_circle_outline, size: 48)
          ],
        ),
      ),
    );
  }
}
