import 'dart:async';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:my_game/game/components/bunny_component.dart';
import 'package:my_game/game/components/lion_component.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/gen/assets.gen.dart';

class NewGame extends FlameGame with HasCollisionDetection {
  NewGame() {
    images.prefix = '';
  }

  final BunnyComponent bunnyComponent = BunnyComponent()..debugMode = true;
  final LionComponent lionComponent = LionComponent()..debugMode = true;
  late TiledComponent homeMap;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      MyAssets.images.bunnySprite.path,
      MyAssets.images.lionSprite.path,
    ]);

    homeMap = await TiledComponent.load(
      MyAssets.tiles.myTile,
      Vector2.all(16),
      prefix: '',
    )
      ..debugMode = true;

    await world.addAll([homeMap, bunnyComponent,lionComponent]);
    bunnyComponent.position = homeMap.size / 2;
    lionComponent.position = homeMap.size / 4;

    camera
      ..follow(bunnyComponent)
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
    bunnyComponent.direction = direction;
  }

  void reset(){
    bunnyComponent.position = homeMap.size / 2;
    lionComponent.position = homeMap.size / 4;
  }
}
