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
  final double speed = 50;

  final Vector2 velocity = Vector2.zero();

  //false means facing left and true means facing right
  bool lionDirection = true;
  @override
  Future<void> onLoad() async {
    final lionSheet = SpriteSheet(
      image: game.images.fromCache(
        MyAssets.images.lionSprite.path,
      ),
      srcSize: Vector2.all(16),
    );

    flyAnimation = lionSheet.createAnimation(row: 0, stepTime: .5, to: 4);
    add(RectangleHitbox(collisionType: CollisionType.active));

    animation = flyAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
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
