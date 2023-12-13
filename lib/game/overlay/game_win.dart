import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_game/game/new_game.dart';

class GameWin extends StatelessWidget {
  const GameWin({required this.game, super.key});
  // Reference to parent game.
  final NewGame game;

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Colors.black;
    const whiteTextColor = Colors.white;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 200,
          width: 300,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Winner',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              )
                  .animate(
                    onComplete: (controller) => controller.repeat(reverse: true),
                  )
                  .scaleXY(duration: 2.seconds)
                  .then()
                  .rotate(duration: 1.seconds),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    game.reset();
                    game.overlays.remove('GameWin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(
                      fontSize: 28,
                      color: blackTextColor,
                    ),
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
