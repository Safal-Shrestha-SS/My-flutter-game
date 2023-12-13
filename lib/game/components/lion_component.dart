import 'dart:async' as timer;
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/game/new_game.dart';
import 'package:my_game/gen/assets.gen.dart';

class LionComponent extends SpriteAnimationComponent with HasGameRef<NewGame> {
  LionComponent() : super(size: Vector2.all(120), anchor: Anchor.center);

  late SpriteAnimation flyAnimation;
  Direction direction = Direction.none;

  late double speed;

  //false means facing left and true means facing right
  bool lionDirection = true;

  bool canBoostSpeed = true;

  late timer.Timer speedBoostTimer;

  @override
  Future<void> onLoad() async {
    speed = 5;
    
    final lionSheet = SpriteSheet(
      image: game.images.fromCache(
        MyAssets.images.lionSprite.path,
      ),
      srcSize: Vector2.all(16),
    );

    flyAnimation = lionSheet.createAnimation(row: 0, stepTime: .7, to: 4);
    add(RectangleHitbox());

    animation = flyAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (canBoostSpeed) {
      if (Random().nextDouble() > 0.8) {
        speed = 200;
        canBoostSpeed = false;
        speedBoostTimer = timer.Timer(const Duration(milliseconds: 500), () {
          speed = 100;
          canBoostSpeed = true;
        });
      }
    }
    final direction = (game.bunnyComponent.position - position).normalized();
    final velocity = direction * speed;
    if (direction.x < 0 && lionDirection) {
      flipHorizontally();
      lionDirection = false;
    }
    if (direction.x > 0 && !lionDirection) {
      flipHorizontally();
      lionDirection = true;
    }
    
    position += velocity * dt;
  }
}
