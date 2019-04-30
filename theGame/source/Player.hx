package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite {
    public var _speed:Float = 200;
    public function new(x:Int, y:Int) {
        super(x, y);

        drag.x = drag.y = 1600;
        makeGraphic(32, 32, FlxColor.BLUE);
    }

    public function movement() {
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;
        
        if (FlxG.keys.anyPressed([UP, W])) {
            _up = true;
        }

        if (FlxG.keys.anyPressed([DOWN, S])) {
            _down = true;
        }

        if (FlxG.keys.anyPressed([LEFT, A])) {
            _left = true;
        }

        if (FlxG.keys.anyPressed([RIGHT, D])) {
            _right = true;
        }

        if (_up && _down) {
            _up = _down = false;
        }

        if (_left && _right) {
            _left = _right = false;
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
        }
    }

    function moveLeft() {
        x -= 20;
    }

    function moveRight() {
        x += 20;
    }

    function moveUp() {
        y -= 20;
    }

    function moveDown() {
        y += 20;
    }

    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }

    override public function destroy():Void {
		super.destroy();
	}
}