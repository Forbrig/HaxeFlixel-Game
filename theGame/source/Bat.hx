package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;

class Bat extends FlxSprite {
    public var _speed:Float = 100;
    public var _facing = '';
    public var _directionAimVect:FlxPoint;

    public function new(x:Int = 0, y:Int = 0) {
        super(x, y);

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
 
    // simple steering behavior
    function seekPlayer(goal:FlxVector):Void {
        var _orientationVector:FlxVector;
        _orientationVector = new FlxVector(goal.x - this.x, goal.y - this.y);
        _orientationVector.normalize();
        _orientationVector.scale(100);

        _directionAimVect = new FlxPoint(_orientationVector.x - acceleration.x, _orientationVector.y - acceleration.y);
        acceleration.x = _directionAimVect.x;
        acceleration.y = _directionAimVect.y;

        if (velocity.x > velocity.y && velocity.x > (velocity.y * -1)) {
             animation.play("right");
            _facing = 'right';
        } else if ((velocity.x * -1) > velocity.y && (velocity.x * -1) > (velocity.y * -1)) {
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

    override public function update(elapsed:Float):Void {
        var playerPosition:FlxVector = new FlxVector(cast(FlxG.state, PlayState)._player.x, cast(FlxG.state, PlayState)._player.y);
        seekPlayer(playerPosition);
        super.update(elapsed);
    }

    override public function destroy():Void {
		super.destroy();
	}
}