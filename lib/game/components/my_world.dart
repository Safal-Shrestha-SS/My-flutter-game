import 'package:flame/components.dart';
import 'package:my_game/gen/assets.gen.dart';

class MyWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(MyAssets.images.rayworldBackground.path);
    size = size;
    return super.onLoad();
  }
}
