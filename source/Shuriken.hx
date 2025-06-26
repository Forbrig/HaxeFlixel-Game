package;

import flixel.FlxSprite;
import flixel.util.FlxDirection;

class Shuriken extends FlxSprite {
	private var _direction:FlxDirection;
	private var _damage:Float;
	private var _speed:Float;

	public function new(x:Float, y:Float, speed:Float, direction:FlxDirection, damage:Float) {
		_direction = direction;
		_speed = speed;
		_damage = damage;

		super(x - 5, y - 5);
		loadGraphic(AssetPaths.shurikens__png, true, 20, 20);

		updateHitbox();
	}

	override public function update(elapsed:Float):Void {
		this.angularVelocity = -1000;
		if (_direction == FlxDirection.LEFT) {
			velocity.x = -_speed;
		}
		if (_direction == FlxDirection.RIGHT) {
			velocity.x = _speed;
		}
		if (_direction == FlxDirection.DOWN) {
			velocity.y = _speed;
		}
		if (_direction == FlxDirection.UP) {
			velocity.y = -_speed;
		}

		if (!isOnScreen()) {
			kill();
		}

		super.update(elapsed);
	}

	override public function destroy():Void {
		super.destroy();
	}
}
