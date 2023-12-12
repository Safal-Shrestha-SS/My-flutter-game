import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/gen/assets.gen.dart';

class Player extends SpriteAnimationComponent with TapCallbacks, HasGameRef {
  Player() : super(size: Vector2.all(120), anchor: Anchor.center);
  bool running = true;
  final double _playerSpeed = 50;
  bool _hasCollided = false;
  Direction _collisionDirection = Direction.none;

  Direction direction = Direction.none;

  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _grenadeAnimation;
  late final SpriteAnimation _grenadeSmokeAnimation;

  @override
  Future<void> onLoad() async {
    _runAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(MyAssets.images.run.path),
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.1,
        textureSize: Vector2.all(128),
      ),
    );
    _grenadeAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(MyAssets.images.grenade.path),
      SpriteAnimationData.sequenced(
        amount: 12,
        stepTime: 0.1,
        textureSize: Vector2.all(128),
        loop: false,
      ),
    );
    _grenadeSmokeAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(MyAssets.images.grenade.path),
      SpriteAnimationData.range(
        start: 7,
        end: 14,
        amount: 16,
        stepTimes: List.filled(8, 0.1),
        textureSize: Vector2.all(128),
      ),
    );
    animation = _runAnimation;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    running = !running;
    if (running) {
      animation = _runAnimation;
    } else {
      animation = _grenadeAnimation;
      animationTicker?.completed.then(
        (value) {
          animation = _grenadeSmokeAnimation;
        },
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }
  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

   void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          // animation = _runUpAnimation;
          moveUp(delta);
        }
      case Direction.down:
        if (canPlayerMoveDown()) {
          // animation = _runDownAnimation;
          moveDown(delta);
        }
      case Direction.left:
        if (canPlayerMoveLeft()) {
          // animation = _runLeftAnimation;
          moveLeft(delta);
        }
      case Direction.right:
        if (canPlayerMoveRight()) {
          // animation = _runRightAnimation;
          moveRight(delta);
        }
      case Direction.none:
        // animation = _standingAnimation;
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
