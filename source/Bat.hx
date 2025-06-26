package;

import flixel.FlxG;
import flixel.FlxSprite;
// import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;

class Bat extends FlxSprite {
	var _speed:Float = 100;
	var _facing = '';
	var _directionAimVect:FlxPoint;
	var flickering:Bool = false;
	var health:Int;

	public function new(x:Int = 0, y:Int = 0) {
		super(x, y);

		health = 3;
		drag.x = drag.y = 100;
		maxVelocity.set(_speed, _speed);

		loadGraphic(AssetPaths.characters__png, true, 16, 16);
		scale.set(2, 2);
		updateHitbox();

		// Animations
		// iddle and moving are the same here
		animation.add("down", [51, 52], 10, false);
		animation.add("up", [87, 88], 10, false);
		animation.add("left", [63, 64], 10, false);
		animation.add("right", [75, 76], 10, false);
	}

	function moveAnimation() {
		if (velocity.x >= velocity.y && velocity.x >= (velocity.y * -1)) {
			animation.play("right");
			_facing = 'right';
		} else if ((velocity.x * -1) >= velocity.y && (velocity.x * -1) >= (velocity.y * -1)) {
			animation.play("left");
			_facing = 'left';
		} else if (velocity.y > velocity.x && velocity.y > (velocity.x * -1)) {
			animation.play("down");
			_facing = 'down';
		} else if ((velocity.y * -1) > velocity.x && (velocity.y * -1) > (velocity.x * -1)) {
			animation.play("up");
			_facing = 'up';
		}
	}

	public function seek(x:Int, y:Int):FlxPoint {
		var target = new FlxPoint(x, y);
		var seek = target.subtractPoint(new FlxPoint(this.x, this.y));
		return seek.normalize().scale(_speed);
	}

	public function flee(x:Int, y:Int):FlxPoint {
		return seek(x, y).scale(-0.5);
	}

	public function hurt(damage:Int):Void {
		if (flickering) {
			return;
		}

		flicker(1);

		health -= damage;

		if (health <= 0) {
			kill();
		}
	}

	function flicker(Duration:Float):Void {
		FlxSpriteUtil.flicker(this, Duration, 0.02, true, true, function(_) {
			flickering = false;
		});
		flickering = true;
	}

	override public function update(elapsed:Float):Void {
		var p = cast(FlxG.state, PlayState).getPlayerById(1);
		var playerPosition:FlxPoint = new FlxPoint(p.x, p.y);
		var steering = new FlxPoint(0, 0);

		// var distance = FlxMath.distanceBetween(p, this);

		// if (distance <= 200) {
		steering.addPoint(seek(Std.int(playerPosition.x + p.width / 2), Std.int(playerPosition.y + p.height / 2)));
		// } else {
		//     steering.addPoint(seek(800, 550));
		// }

		acceleration.x = steering.x;
		acceleration.y = steering.y;

		moveAnimation();
		super.update(elapsed);
	}

	override public function destroy():Void {
		super.destroy();
	}
}
