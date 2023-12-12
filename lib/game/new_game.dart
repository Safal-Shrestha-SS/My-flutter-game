import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:my_game/game/components/bunny_component.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/gen/assets.gen.dart';

class NewGame extends FlameGame {
  NewGame() {
    images.prefix = '';
  }

  final BunnyComponent _bunnyComponent = BunnyComponent()..debugMode = true;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      MyAssets.images.bunnySprite.path,
    ]);

    final homeMap = await TiledComponent.load(
      MyAssets.tiles.myTile,
      Vector2.all(16),
      prefix: '',
    )
      ..debugMode = true;

    await world.addAll([homeMap, _bunnyComponent]);
    _bunnyComponent.position = homeMap.size/2;

    camera
      ..follow(_bunnyComponent)
      ..setBounds(
        Rectangle.fromCenter(
          center: homeMap.center,
          size: homeMap.size - camera.viewport.size,
        ),
      );

    return super.onLoad();
  }

  // ignore: use_setters_to_change_properties
  void onJoypadDirectionChanged(Direction direction) {
    _bunnyComponent.direction = direction;
  }
}
