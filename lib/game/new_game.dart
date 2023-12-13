import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:my_game/game/components/bunny_component.dart';
import 'package:my_game/game/components/lion_component.dart';
import 'package:my_game/game/components/obstacle_component.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/gen/assets.gen.dart';

class NewGame extends FlameGame with HasCollisionDetection {
  NewGame() {
    images.prefix = '';
  }

  final BunnyComponent bunnyComponent = BunnyComponent()..debugMode = true;
  final LionComponent lionComponent = LionComponent()..debugMode = true;
  late TiledComponent homeMap;
  bool gameOver = false;
  bool gameWin = false;
  late Timer gameTimer;

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

    await world.addAll([homeMap, bunnyComponent, lionComponent]);
    bunnyComponent.position = homeMap.size / 2;
    lionComponent.position = homeMap.size / 4;

    final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('Water');
    for (final obstacle in obstacleGroup!.objects) {
      world.add(
        ObstacleComponent()
          ..position = Vector2(
            obstacle.x,
            obstacle.y,
          )
          ..width = obstacle.width
          ..height = obstacle.height
          ..debugMode = true,
      );
    }

    camera
      ..follow(bunnyComponent)
      ..setBounds(
        Rectangle.fromCenter(
          center: homeMap.center,
          size: homeMap.size - camera.viewport.size,
        ),
      );
    startGameTimer();
    return super.onLoad();
  }

  // ignore: use_setters_to_change_properties
  void onJoypadDirectionChanged(Direction direction) {
    bunnyComponent.direction = direction;
  }

  @override
  void update(double dt) {
    if (gameOver) {
      gameTimer.cancel();
      overlays.add('GameOver');
    }
    if (gameWin) {
      overlays.add('GameWin');
      lionComponent.removeFromParent();
    }
    super.update(dt);
  }

  void startGameTimer() {
    const duration = Duration(seconds: 25);
    gameTimer = Timer(duration, () {
      gameWin = true;
    });
  }

  void reset() {
    gameOver = false;
    if (gameWin) {
      world.add(lionComponent);
    }
    gameWin = false;
    bunnyComponent.position = homeMap.size / 2;
    lionComponent.position = homeMap.size / 4;
    startGameTimer();
  }
}
