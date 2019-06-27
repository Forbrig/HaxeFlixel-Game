package;

import flixel.*;

class Shuriken extends FlxSprite {
    private var _direction:Int;
    private var _damage:Float;
    private var _speed:Float;

    public function new(x:Float, y:Float, speed:Float, direction:Int, damage:Float) {
        _direction = direction;
        _speed = speed;
        _damage = damage;

        super(x - 5, y - 5);
		loadGraphic(AssetPaths.shurikens__png, true, 20, 20);

        // makeGraphic(10, 10, 0xffff0000);
        // kill();
        updateHitbox();
    }

    override public function update(elapsed:Float):Void {

        this.angularVelocity = -1000;
        if (_direction == FlxObject.LEFT){
            velocity.x = -_speed;     
        }
        if (_direction == FlxObject.RIGHT){
            velocity.x = _speed;     
        }
        if (_direction == FlxObject.FLOOR){
            velocity.y = _speed;     
        }
        if (_direction == FlxObject.CEILING){
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