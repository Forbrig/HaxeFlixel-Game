import flixel.*;

class Bullet extends FlxSprite {
    private var _direction:Int;
    private var _damage:Float;
    private var _speed:Float;
    public function new(x:Float, y:Float, speed:Float, direction:Int, damage:Float) {
        _direction = direction;
        _speed = speed;
        _damage = damage;

        super(x - 5, y - 5);
        makeGraphic(10, 10, 0xffff0000);
        // kill();
    }

    override public function update(elapsed:Float):Void {
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
            // FlxG.log.add("bullet killed");
        }

        super.update(elapsed);
    }

    override public function destroy():Void {
        super.destroy();
    }
}

	
// package;
 
// import flixel.FlxSprite;
// import flixel.FlxG;
// import flixel.FlxObject;
// import flixel.util.FlxVelocity;
// import flixel.util.FlxAngle;
// import flixel.util.FlxPoint;
 
// class Bullet extends FlxSprite
// {
 
//     private var speed:Float;
//     private var direction:Int;
//     private var damage:Float;
 
//     public function new(X:Float, Y:Float,Speed:Float,Direction:Int,Damage:Float)
//     {
//         super(X,Y);
//         speed = Speed;
//         direction = Direction;
//         damage = Damage;
//         loadGraphic(Reg.BULLET, true, 6, 6, true, "bullet");
//     }
 
//     override public function update():Void
//     {
//         super.update();
//         if (direction == FlxObject.LEFT){
//             velocity.x = -speed;     
//         }
//         if (direction == FlxObject.RIGHT){
//             velocity.x = speed;     
//         }
//         if (direction == FlxObject.FLOOR){
//             velocity.y = speed;     
//         }
//         if (direction == FlxObject.CEILING){
//             velocity.y = -speed;     
//         }
        
//     }
 
//     override public function destroy():Void
//     {
//         super.destroy();
//     }
 
// }