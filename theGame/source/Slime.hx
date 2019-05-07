package;

import flixel.FlxG;
import flixel.FlxSprite;
// import flixel.system.FlxAssets;
// import flixel.util.FlxColor;


class Slime extends FlxSprite {
    public var _speed:Float = 100;
    public var _facing = '';


    public function new(x:Int, y:Int) {
        super(x, y);

        drag.x = drag.y = 2000;
        maxVelocity.set(_speed, _speed);

		loadGraphic(AssetPaths.characters__png, true, 16, 16);
        scale.set(2, 2);
        updateHitbox();

        // Animations
        animation.add("iddle_down", [49], 6, false);
        animation.add("iddle_up", [85], 6, false);
        animation.add("iddle_left", [61], 6, false);
        animation.add("iddle_right", [73], 6, false);

        animation.add("walking_down", [48, 49, 50], 6, false);
        animation.add("walking_up", [84, 85, 86], 6, false);
        animation.add("walking_left", [60, 61, 62], 6, false);
        animation.add("walking_right", [72, 73, 74], 6, false);

        // makeGraphic(32, 32, FlxColor.BLUE);
    }
 
    override public function update(elapsed:Float):Void {
        animation.play("iddle_down");
        super.update(elapsed);
    }

    override public function destroy():Void {
		super.destroy();
	}
}