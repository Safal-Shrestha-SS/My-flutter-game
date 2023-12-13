import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:my_game/game/components/bunny_component.dart';
import 'package:my_game/game/helpers/direction.dart';
import 'package:my_game/game/new_game.dart';

class ObstacleComponent extends PositionComponent
    with HasGameRef<NewGame>, CollisionCallbacks {
  ObstacleComponent() {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BunnyComponent &&  !game.bunnyComponent.hasCollided ) {
      game.bunnyComponent.hasCollided = true;
      game.bunnyComponent.collisionDirection = game.bunnyComponent.direction;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is BunnyComponent) {
      game.bunnyComponent.hasCollided = false;
      game.bunnyComponent.collisionDirection = Direction.none;
    }
    super.onCollisionEnd(other);
  }
}
