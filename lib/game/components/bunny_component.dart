import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/gen/assets.gen.dart';

class BunnyComponent extends SpriteAnimationComponent with HasGameRef {
  BunnyComponent() : super(size: Vector2.all(120), anchor: Anchor.topLeft);

  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation idleAnimation;

  Direction direction = Direction.none;
  final double _playerSpeed = 250;

  @override
  Future<void> onLoad() async {
    final bunnySheet = SpriteSheet(
      image: game.images.fromCache(
        MyAssets.images.bunnySprite.path,
      ),
      srcSize: Vector2.all(48),
    );

    idleAnimation = bunnySheet.createAnimation(row: 0, stepTime: .5, to: 1);
    upAnimation = bunnySheet.createAnimation(row: 1, stepTime: .5, to: 4);
    leftAnimation = bunnySheet.createAnimation(row: 2, stepTime: .5, to: 4);
    rightAnimation = bunnySheet.createAnimation(row: 3, stepTime: .5, to: 4);
    downAnimation = bunnySheet.createAnimation(row: 0, stepTime: .5, to: 4);

    animation = idleAnimation;
  }

   @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        // if (canPlayerMoveUp()) {
          animation = upAnimation;
          moveUp(delta);
        // }
      case Direction.down:
        // if (canPlayerMoveDown()) {
          animation = downAnimation;
          moveDown(delta);
        // }
      case Direction.left:
        // if (canPlayerMoveLeft()) {
          animation = leftAnimation;
          moveLeft(delta);
        // }
      case Direction.right:
        // if (canPlayerMoveRight()) {
          animation = rightAnimation;
          moveRight(delta);
        // }
      case Direction.none:
        animation = idleAnimation;
        break;
    }
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }
}
