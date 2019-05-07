package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

// import flixel.system.FlxAssets;
// import flixel.util.FlxColor;


class Player extends FlxSprite {
	public var flickering:Bool = false;
    public var _speed:Float = 150;
    public var _facing = '';


    public function new(x:Int, y:Int) {
        super(x, y);

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

        animation.add("walking_up", [36, 37, 38], 6, false);
        animation.add("walking_down", [0, 1, 2], 6, false);
        animation.add("walking_left", [12, 13, 14], 6, false);
        animation.add("walking_right", [24, 25, 26], 6, false);

        // makeGraphic(32, 32, FlxColor.BLUE);
    }

    function movement() {
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;

        if (FlxG.keys.anyPressed([UP, W])) {
            _up = true;
            _facing = 'up';
        }

        if (FlxG.keys.anyPressed([DOWN, S])) {
            _down = true;
            _facing = 'down';
        }

        if (FlxG.keys.anyPressed([LEFT, A])) {
            _left = true;
            _facing = 'left';
        }

        if (FlxG.keys.anyPressed([RIGHT, D])) {
            _right = true;
            _facing = 'right';
        }

        // if (_up && _down) {
        //     _up = _down = false;
        // }

        // if (_left && _right) {
        //     _left = _right = false;
        // }

        if (_left && _up || _left && _down || _right && _up || _right && _down || _up && _down || _left && _right) {
            _up = _down = _left = _right = false;
        }

        if (_up || _down || _left || _right) {
            if (_up) {
                moveUp();
            } else if (_down) {
                moveDown();
            }

            if (_left) {
                moveLeft();
            } else if (_right) {
                moveRight();
            }

        } else {
            // idle
            switch (_facing) {
                case 'up':
                    animation.play("iddle_up");
                case 'down':
                    animation.play("iddle_down");
                case 'left':
                    animation.play("iddle_left");
                case 'right':
                    animation.play("iddle_right");

            }
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

    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }

    override public function hurt(damage:Float):Void{
        if (flickering) {
			return;
		}
		
		flicker(1);

		super.hurt(damage);
	}

    function flicker(Duration:Float):Void {
		FlxSpriteUtil.flicker(this, Duration, 0.02, true, true, function(_) {
			flickering = false;
		});
		flickering = true;
	}

    override public function destroy():Void {
		super.destroy();
	}
}