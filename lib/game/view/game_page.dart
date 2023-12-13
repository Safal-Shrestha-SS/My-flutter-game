import 'package:flame/game.dart' hide Route;
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/game/game.dart';
import 'package:my_game/game/new_game.dart';
import 'package:my_game/game/overlay/game_over.dart';
import 'package:my_game/game/overlay/game_win.dart';
import 'package:my_game/game/overlay/joypad_overlay.dart';
import 'package:my_game/gen/assets.gen.dart';
import 'package:my_game/loading/cubit/cubit.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const GamePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AudioCubit(audioCache: context.read<PreloadCubit>().audio);
      },
      child: const Scaffold(
        body: SafeArea(child: GameView()),
      ),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {

  late final Bgm bgm;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    bgm = context.read<AudioCubit>().bgm;
    bgm.play(MyAssets.audio.background);
  }

  @override
  void dispose() {
    bgm.pause();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // VeryGoodFlameGame(
    //   l10n: context.l10n,
    //   effectPlayer: context.read<AudioCubit>().effectPlayer,
    //   textStyle: textStyle,
    // );
    return Stack(
      children: [ 
        Positioned.fill(
          child: GameWidget<NewGame>.controlled(
            gameFactory: NewGame.new,
            overlayBuilderMap: {
              'JoyPad': (_, game) => JoyPadOverlay(game: game),
              'GameOver': (_, game) => GameOver(game: game),
              'GameWin':(_, game) => GameWin(game: game)
            },
            initialActiveOverlays: const ['JoyPad']
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.volume == 0 ? Icons.volume_off : Icons.volume_up,
                ),
                onPressed: () => context.read<AudioCubit>().toggleVolume(),
              );
            },
          ),
        ),
      ],
    );
  }
}
