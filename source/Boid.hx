import flixel.*;
import flixel.math.*;

class Boid extends FlxSprite {
    var _speed:Float = 50;
    public function new() {
        super(FlxG.width / 2, FlxG.height / 2);

        maxVelocity.set(_speed, _speed);
        velocity.x = 10;
        velocity.y = 10;

    }

    public function seek(x:Int, y:Int):FlxPoint {
        var target = new FlxPoint(x, y);
        var seek = target.subtractPoint(
            new FlxPoint(this.x, this.y)
        );
        return seek.normalize().scale(20);
    }

    public function flee(x:Int, y:Int): FlxPoint {
        return seek(x, y).scale(-0.75);
    }

    public function arrive(x:Int, y:Int, radio:Float): FlxPoint {
        var target = new FlxPoint(x, y);
        var direto = target.subtractPoint(
            new FlxPoint(this.x, this.y)
        );

        // inside area
        if (direto.length <= radio) {
            // FlxG.log.add("inside");
            return new FlxPoint(velocity.x, velocity.y).normalize().scale(-20);
        } else {
            return new FlxPoint();
            // FlxG.log.add("outside");
        }

        return direto;
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        var steering =  new FlxPoint(0, 0);
        // steering.addPoint(flee(FlxG.mouse.x, FlxG.mouse.y));
        steering.addPoint(seek(FlxG.mouse.x, FlxG.mouse.y));
        // steering.addPoint(seek(cast(FlxG.width / 2, Int), cast(FlxG.height / 2, Int)));

        steering.addPoint(arrive(FlxG.mouse.x, FlxG.mouse.y, 50));

        acceleration.x = steering.x;
        acceleration.y = steering.y;
    }
}