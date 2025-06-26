package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.input.keyboard.*;
import flixel.util.FlxDirection;
import flixel.util.FlxSpriteUtil;

class Player extends FlxSprite {
	private var bulletArray:FlxTypedGroup<Shuriken>;

	public var _id:Int;

	var flickering:Bool = false;
	var _speed:Float = 150;
	var _facing:FlxDirection;
	var _keys = [];

	public var health:Int;

	public function new(x:Int, y:Int, playerBulletArray:FlxTypedGroup<Shuriken>, keys:Array<FlxKey>) {
		bulletArray = playerBulletArray;
		super(x, y);
		_keys = keys;
		health = 3;
		drag.x = drag.y = 2000;
		maxVelocity.set(_speed, _speed);

		loadGraphic(AssetPaths.characters__png, true, 16, 16);

		scale.set(2, 2);
		updateHitbox();

		// Animations
		animation.add("iddle_up", [37], 6, false);
		animation.add("iddle_down", [1], 6, false);
		animation.add("iddle_left", [13], 6, false);
		animation.add("iddle_right", [25], 6, false);

		animation.add("walking_up", [36, 37, 38, 37], 6, false);
		animation.add("walking_down", [0, 1, 2, 1], 6, false);
		animation.add("walking_left", [12, 13, 14, 13], 6, false);
		animation.add("walking_right", [24, 25, 26, 25], 6, false);
	}

	function movement() {
		if (FlxG.keys.anyPressed([_keys[0]])) {
			_facing = FlxDirection.UP;
			moveUp();
		} else if (FlxG.keys.anyPressed([_keys[1]])) {
			_facing = FlxDirection.DOWN;
			moveDown();
		} else if (FlxG.keys.anyPressed([_keys[2]])) {
			_facing = FlxDirection.LEFT;
			moveLeft();
		} else if (FlxG.keys.anyPressed([_keys[3]])) {
			_facing = FlxDirection.RIGHT;
			moveRight();
		}
	}

	function moveLeft() {
		velocity.x -= _speed;
		animation.play("walking_left");
	}

	function moveRight() {
		velocity.x += _speed;
		animation.play("walking_right");
	}

	function moveUp() {
		velocity.y -= _speed;
		animation.play("walking_up");
	}

	function moveDown() {
		velocity.y += _speed;
		animation.play("walking_down");
	}

	private function attack():Void {
		var newBullet = new Shuriken(this.x + (this.height / 2), this.y + (this.width / 2), 500, this._facing, 10);
		bulletArray.add(newBullet);
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

	// when player hurt he flicker and become invulnerable for a short time
	function flicker(Duration:Float):Void {
		FlxSpriteUtil.flicker(this, Duration, 0.02, true, true, function(_) {
			flickering = false;
		});
		flickering = true;
	}

	override public function update(elapsed:Float):Void {
		movement();

		if (FlxG.keys.justPressed.SPACE) {
			attack();
		}
		super.update(elapsed);
	}

	override public function destroy():Void {
		super.destroy();
	}
}
