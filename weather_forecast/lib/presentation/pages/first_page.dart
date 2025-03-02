import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensures the container takes full width
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2B2B54), // Dark blue/purple
              Color(0xFF6B2B8C), // Purple
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/images/weather_icon.png', // Local image
              height: 428,
              width: 428,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 51),
            Image.asset(
              'lib/assets/images/weather_forecasts_text.png', // Local image
              height: 154,
              width: 428,
            ),
            const SizedBox(height: 53),
            ElevatedButton(
              onPressed: () {
                print("Button Clicked!");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDDB130), // Set button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Rounded corners
                ),
                minimumSize: Size(304, 72),
              ),
              child: const Text(
                "Get Start",
                style: TextStyle(
                    color: Color(0xFF362A84),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.47, //add space between letters
                    fontFamily: 'OpenSans'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
