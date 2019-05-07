package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
    var _txtHealth:FlxText;

    public function new() {
        super();
        _txtHealth = new FlxText(32, 2, 0, "3 / 3", 32);
        _txtHealth.color = FlxColor.RED;
        _txtHealth.setBorderStyle(SHADOW, FlxColor.BLACK, 1, 1);
        add(_txtHealth);
        forEach(function(spr:FlxSprite) {
            spr.scrollFactor.set(0, 0);
        });
    }

    public function updateHUD(Health:Float = 0):Void {
        _txtHealth.text = Std.string(Health) + " / 3";
    }
}