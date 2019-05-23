package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.*;

class Bat extends FlxSprite {
    var _speed:Float = 100;
    var _facing = '';
    var _directionAimVect:FlxPoint;

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
    // function seekPlayer(goal:FlxVector):Void {
    //     var _orientationVector:FlxVector;
    //     _orientationVector = new FlxVector(goal.x - this.x, goal.y - this.y);
    //     _orientationVector.normalize();
    //     _orientationVector.scale(100);

    //     _directionAimVect = new FlxPoint(_orientationVector.x - acceleration.x, _orientationVector.y - acceleration.y);
    //     acceleration.x = _directionAimVect.x;
    //     acceleration.y = _directionAimVect.y;

    //     if (velocity.x > velocity.y && velocity.x > (velocity.y * -1)) {
    //          animation.play("right");
    //         _facing = 'right';
    //     } else if ((velocity.x * -1) > velocity.y && (velocity.x * -1) > (velocity.y * -1)) {
    //         animation.play("left");
    //         _facing = 'left';
    //     } else if (velocity.y > velocity.x && velocity.y > (velocity.x * -1)) {
    //         animation.play("down");
    //         _facing = 'down';
    //     } else if ((velocity.y * -1) > velocity.x && (velocity.y * -1) > (velocity.x * -1)) {
    //         animation.play("up");
    //         _facing = 'up';
    //     }
    // }

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

    public function seek(x:Int, y:Int):FlxVector {
        var target = new FlxVector(x, y);
        var seek = target.subtractPoint(
            new FlxVector(this.x, this.y)
        );
        return seek.normalize().scale(_speed);
    }

    public function flee(x:Int, y:Int): FlxVector {
        return seek(x, y).scale(-0.5);
    }

    override public function update(elapsed:Float):Void {
        var p = cast(FlxG.state, PlayState).getPlayerById(1);
        var playerPosition:FlxVector = new FlxVector(p.x, p.y);
        var steering = new FlxVector(0, 0);

        // var distance = playerPosition.subtractPoint(
        //     new FlxVector(this.x, this.y)
        // );
            // FlxG.log.add(distance.length);
        var distance = FlxMath.distanceBetween(p, this);


        if (distance <= 200) {
            steering.addPoint(seek(Std.int(playerPosition.x + p.width/2), Std.int(playerPosition.y + p.height/2)));
        } else {
            steering.addPoint(seek(Std.int(800), Std.int(550)));
        }

        // steering.addPoint(seek(Std.int(playerPosition.x), Std.int(playerPosition.y)));


        // var slimePosition:FlxVector = new FlxVector(cast(FlxG.state, PlayState)._slime.x, cast(FlxG.state, PlayState)._slime.y);
        // seekPlayer(playerPosition);

        // steering.addPoint(seek(Std.int(slimePosition.x), Std.int(slimePosition.y)));
        // steering.addPoint(seek(Std.int(playerPosition.x), Std.int(playerPosition.y)));

        acceleration.x = steering.x;
        acceleration.y = steering.y;

        moveAnimation();
        super.update(elapsed);
    }

    override public function destroy():Void {
		super.destroy();
	}
}