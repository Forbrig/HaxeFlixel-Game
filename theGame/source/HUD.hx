package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
    var _txtElapsedTime:FlxText;
    var _txtHealth:FlxText;
    // var _shourikens
    var _count:Float = 0;

    public function new() {
        super();
        _txtElapsedTime = new FlxText(FlxG.width/2, 2, 0, "0", 32);
        _txtElapsedTime.color = FlxColor.RED;

        _txtHealth = new FlxText(32, 2, 0, "3 / 3", 32);
        _txtHealth.color = FlxColor.RED;
        _txtHealth.setBorderStyle(SHADOW, FlxColor.BLACK, 1, 1);




        add(_txtHealth);
        add(_txtElapsedTime);
        forEach(function(spr:FlxSprite) {
            spr.scrollFactor.set(0, 0);
        });
    }

    public function updateHUD(Health:Float = 0):Void {
        _txtHealth.text = Std.string(Health) + " / 3";
    }

    override public function update(e:Float):Void {
        _count += e;
        _txtElapsedTime.text = Std.string(Std.int(_count));

        super.update(e);
    }
}