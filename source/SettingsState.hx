package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class SettingsState extends FlxState {
    var _titleSettings:FlxText;
    var _textVolume:FlxText;
    var _textFullscreen:FlxText;
    var _btnBack:FlxButton;
    
    override public function create():Void {
        _titleSettings = new FlxText(0, 0, 0, "Settings", 40);
        _titleSettings.x = FlxG.width/2 - _titleSettings.width/2;
        _titleSettings.y = _titleSettings.height/2;

        // ------- SETTINGS -------
        _textVolume = new FlxText(0, 0, 0, "Volume", 10);
        _textVolume.x = FlxG.width/2 - _textVolume.width/2 - 100;
        _textVolume.y = _titleSettings.y + _titleSettings.height/2 + _textVolume.height/2 + 20;
        _textVolume.color = 0x001ce202;
        _textVolume.alignment = CENTER;

        // ------- BUTTON BACK -------
        _btnBack = new FlxButton(0, 0, "Back", goMenu);
        _btnBack.x = FlxG.width - _btnBack.width - 40;
        _btnBack.y = FlxG.height - _btnBack.height - 40;

        add(_titleSettings);
        add(_textVolume);
        add(_btnBack);
        super.create();
    }

    override public function destroy():Void {
		super.destroy();
	}

    function goMenu():Void {
        FlxG.switchState(()->new MenuState());
    }
}