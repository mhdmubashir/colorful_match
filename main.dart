import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyColorGameApp());
}

class MyColorGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COLORFUL MATCH',
      home: StartScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF81C784), // Light Green
        scaffoldBackgroundColor: Color(0xFFFCE4EC), // Misty Pink
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF64B5F6), // Material Blue
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COLORFUL MATCH'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameScreen()),
            );
          },
          child: Image.asset(
            'assets/1702139585207.png',
            height: 150,
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];
  Random random = Random();
  late Color
      promptColor; // Use 'late' to indicate that it will be initialized before use
  int score = 0;
  int roundsCompleted = 0;

  @override
  void initState() {
    super.initState();
    promptColor = Colors
        .red; // Initialize with a default color, you can change it to any color you prefer
    generateNewRound();
  }

  void generateNewRound() {
    setState(() {
      promptColor = colors[random.nextInt(colors.length)];
    });
  }

  void onObjectTap(Color tappedColor) {
    if (tappedColor == promptColor) {
      setState(() {
        score++;
        roundsCompleted++;
      });
      generateNewRound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COLORFUL MATCH'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Score: $score',
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
          Text(
            'Round: $roundsCompleted',
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: promptColor,
              borderRadius: BorderRadius.circular(20.0), // Rounded edges
            ),
            child: Center(
              child: Text(
                'Tap on the color',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Container(
            height: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onObjectTap(colors[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded edges
                    ),
                    child: Center(
                      child: Text(
                        'Object',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
