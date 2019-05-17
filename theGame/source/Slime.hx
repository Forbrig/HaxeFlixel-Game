package;

import flixel.math.FlxVector;
import flixel.FlxG;
import flixel.FlxSprite;
// import flixel.system.FlxAssets;
// import flixel.util.FlxColor;


class Slime extends FlxSprite {
    var _speed:Float = 100;
    var _facing = '';

    public function new(x:Int, y:Int) {
        super(x, y);

        // drag.x = drag.y = 2000;
        maxVelocity.set(_speed, _speed);

		loadGraphic(AssetPaths.characters__png, true, 16, 16);
        scale.set(2, 2);
        updateHitbox();

        // Animations
        animation.add("down", [48, 49, 50], 6, false);
        animation.add("up", [84, 85, 86], 6, false);
        animation.add("left", [60, 61, 62], 6, false);
        animation.add("right", [72, 73, 74], 6, false);
    }
 
    // straight foard chase
    function seekPlayer(goal:FlxVector):Void {
        var _orientationVector:FlxVector;
        _orientationVector = new FlxVector(goal.x - this.x, goal.y - this.y);
        // _orientationVector.normalize();
        // _orientationVector.scale(_speed);

        acceleration.x = _orientationVector.x;
        acceleration.y = _orientationVector.y;

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

    override public function update(elapsed:Float):Void {
        var p = cast(FlxG.state, PlayState).getPlayerById(1);
        var playerPosition:FlxVector = new FlxVector(p.x, p.y);
        // var playerPosition:FlxVector = new FlxVector(cast(FlxG.state, PlayState)._player.x, cast(FlxG.state, PlayState)._player.y);
        seekPlayer(playerPosition);
        super.update(elapsed);
    }

    override public function destroy():Void {
		super.destroy();
	}
}