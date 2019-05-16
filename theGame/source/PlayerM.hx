package;

import flixel.*;
import flixel.input.keyboard.*;

class PlayerM extends FlxSprite {
    public var _id:Int;
    var _keyUp:FlxKey;
    var _keyDown:FlxKey;
    var _keyLeft:FlxKey;
    var _keyRight:FlxKey;

    public function new(id:Int, keyUp:FlxKey, keyDown:FlxKey, keyLeft:FlxKey, keyRight:FlxKey) {
        _id = id;
        _keyUp = keyUp;
        _keyDown = keyDown;
        _keyLeft = keyLeft;
        _keyRight = keyRight;
        
        super();
    }

    override public function update(e:Float) {
        super.update(e);

        if (FlxG.keys.anyPressed([_keyUp]))       y -= 1;
        if (FlxG.keys.anyPressed([_keyDown]))     y += 1;
        if (FlxG.keys.anyPressed([_keyLeft]))     x -= 1;
        if (FlxG.keys.anyPressed([_keyRight]))    x += 1;
    }
}