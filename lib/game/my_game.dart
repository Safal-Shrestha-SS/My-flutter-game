// ignore_for_file: use_setters_to_change_properties

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:my_game/game/components/my_world.dart';
import 'package:my_game/game/components/player_component.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/gen/assets.gen.dart';
import 'package:my_game/l10n/l10n.dart';

class VeryGoodFlameGame extends FlameGame with HasCollisionDetection {
  VeryGoodFlameGame({
    required this.l10n,
    required this.effectPlayer,
    required this.textStyle,
  }) {
    images.prefix = '';
  }

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  int counter = 0;

  final Player _player = Player();

  final World _world = World();
  final MyWorld _myWorld = MyWorld();

  @override
  Color backgroundColor() => Colors.red;

  @override
  Future<void> onLoad() async {
    log(MyAssets.tiles.myTile);
    final homeMap = await TiledComponent.load(
      MyAssets.tiles.myTile,
      Vector2.all(16),
      prefix: '',
    );
    add(homeMap);
    await images.loadAll([
      MyAssets.images.run.path,
      MyAssets.images.grenade.path,
    ]);
    _player.position = size / 2;
    // final camera = CameraComponent(world: _world);
    // await addAll([camera, _world]);
    // _world.add(_myWorld);
    add(_player);
    // camera.follow(_player, snap: true);
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }
}
