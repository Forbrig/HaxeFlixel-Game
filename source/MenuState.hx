package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState {
	var _title:FlxText;
	var _btnPlay:FlxButton;
	var _btnSettings:FlxButton;
	var _btnCredits:FlxButton;

	override public function create():Void {
		FlxG.mouse.visible = true;

		// don't restart the music if it's already playing
		if (FlxG.sound.music == null) {
			FlxG.sound.playMusic(AssetPaths.awesomeness__wav, 1, true);
		}

		_title = new FlxText(0, 0, 0, "The Game", 80);
		_title.x = FlxG.width / 2 - _title.width / 2;
		_title.y = 180;

		_btnPlay = new FlxButton(0, 0, "Play", goPlay);
		_btnPlay.scale.set(2, 2);
		_btnPlay.x = FlxG.width / 2 - _btnPlay.width / 2;
		_btnPlay.y = FlxG.height / 2 - _btnPlay.height / 2 + 10;

		_btnSettings = new FlxButton(0, 0, "Settings", goSettings);
		_btnSettings.scale.set(2, 2);
		_btnSettings.x = FlxG.width / 2 - _btnSettings.width / 2;
		_btnSettings.y = _btnPlay.y + (_btnPlay.height * 2) + 10;

		_btnCredits = new FlxButton(0, 0, "Credits", goCredits);
		_btnCredits.scale.set(2, 2);
		_btnCredits.x = FlxG.width / 2 - _btnCredits.width / 2;
		_btnCredits.y = _btnSettings.y + (_btnSettings.height * 2) + 10;

		add(_title);
		add(_btnPlay);
		add(_btnSettings);
		add(_btnCredits);
		super.create();
	}

	override public function destroy():Void {
		super.destroy();
	}

	function goPlay():Void {
		FlxG.sound.music.pause();
		FlxG.switchState(() -> new PlayState());
	}

	function goSettings():Void {
		FlxG.switchState(() -> new SettingsState());
	}

	function goCredits():Void {
		FlxG.switchState(() -> new CreditsState());
	}
}
