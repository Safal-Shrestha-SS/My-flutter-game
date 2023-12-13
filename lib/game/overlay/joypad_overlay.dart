import 'package:flutter/material.dart';
import 'package:my_game/game/helpers/joypad.dart';
import 'package:my_game/game/new_game.dart';

class JoyPadOverlay extends StatelessWidget {
  const JoyPadOverlay({required this.game, super.key});
  // Reference to parent game.
  final NewGame game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child:
                    Joypad(onDirectionChanged: game.onJoypadDirectionChanged),
              )
            ],
          ),
        ),
      ),
    );
  }
}
