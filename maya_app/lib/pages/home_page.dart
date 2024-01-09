// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

void playAudio() async {
  final player = AudioPlayer();
  await player.play(AssetSource('audio/greetings/greeting1.wav'));
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (i) {
      var controller = AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this,
        upperBound: (i == 1 || i == 2) ? 0.9 : 1.0,
      );

      if (i == 1 || i == 3) {
        controller.repeat(reverse: true);
      } else {
        Future.delayed(const Duration(milliseconds: 200), () {
          controller.repeat(reverse: true);
        });
      }

      return controller;
    });

    _animations = _controllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            ))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              // Wrap the Stack widget in a GestureDetector
              onTap: () {
                print('Image button tapped!');
                playAudio();
                // Add your button tap handling code here
              },
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(6, (i) {
                  if (i == 0 || i == 5) {
                    // No animation for images 0 and 5
                    return Image.asset('assets/images/$i.png');
                  } else {
                    return AnimatedBuilder(
                      animation: _animations[i],
                      builder: (_, __) => Transform.rotate(
                        // Rotate anticlockwise for images 1, 2, and 4, and clockwise for image 3
                        angle: (i == 3 ? 1 : -1) *
                            _animations[i].value *
                            2.0 *
                            3.14,
                        child: Image.asset('assets/images/$i.png'),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
