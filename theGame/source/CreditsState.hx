package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CreditsState extends FlxState {
    var _titleCredits:FlxText;
    var _titleCreated:FlxText;
    var _textCreated:FlxText;
    var _titleArt:FlxText;
    var _textArt:FlxText;
    var _titleMusic:FlxText;
    var _textMusic:FlxText;
    var _btnBack:FlxButton;
    
    override public function create():Void {
        _titleCredits = new FlxText(0, 0, 0, "Credits", 40);
        _titleCredits.x = FlxG.width/2 - _titleCredits.width/2;
        _titleCredits.y = _titleCredits.height/2;

        // ------- CREATED BY -------
        _titleCreated = new FlxText(0, 0, 0, "[Created by]", 20);
        _titleCreated.x = FlxG.width/2 - _titleCreated.width/2;
        _titleCreated.y = _titleCredits.y + _titleCredits.height/2 + _titleCreated.height/2 + 20;
        _titleCreated.color = 0x001ce202;
        _titleCreated.alignment = CENTER;

        _textCreated = new FlxText(0, 0, 0, "Vitor G. Forbrig\ngithub.com/Forbrig", 10);
        _textCreated.x = FlxG.width/2 - _textCreated.width/2;
        _textCreated.y = _titleCreated.y + _titleCreated.height/2 + _textCreated.height/2 + 10;
        _textCreated.color = 0x001ce202;
        _textCreated.alignment = CENTER;

        // ------- ART BY -------
        _titleArt = new FlxText(0, 0, 0, "[Art]", 20);
        _titleArt.x = FlxG.width/2 - _titleArt.width/2;
        _titleArt.y = _textCreated.y + _textCreated.height/2 + _titleArt.height/2 + 20;
        _titleArt.color = 0x001ce202;
        _titleArt.alignment = CENTER;

        _textArt = new FlxText(0, 0, 0, "xxxx\navailable for free at: opengameart.org", 10);
        _textArt.x = FlxG.width/2 - _textArt.width/2;
        _textArt.y = _titleArt.y + _titleArt.height/2 + _textArt.height/2 + 10;
        _textArt.color = 0x001ce202;
        _textArt.alignment = CENTER;

        // ------- MUSIC BY -------
        _titleMusic = new FlxText(0, 0, 0, "[Music]", 20);
        _titleMusic.x = FlxG.width/2 - _titleMusic.width/2;
        _titleMusic.y = _textArt.y + _textArt.height/2 + _titleMusic.height/2 + 20;
        _titleMusic.color = 0x001ce202;
        _titleMusic.alignment = CENTER;

        _textMusic = new FlxText(0, 0, 0, "Menu:                  awesomeness by mrpoly\navailable for free at: opengameart.org", 10);
        _textMusic.x = FlxG.width/2 - _textMusic.width/2;
        _textMusic.y = _titleMusic.y + _titleMusic.height/2 + _textMusic.height/2 + 10;
        _textMusic.color = 0x001ce202;
        _textMusic.alignment = CENTER;

        // ------- BUTTON BACK -------
        _btnBack = new FlxButton(0, 0, "Back", goMenu);
        _btnBack.x = FlxG.width - _btnBack.width - 40;
        _btnBack.y = FlxG.height - _btnBack.height - 40;

        add(_titleCredits);
        add(_titleCreated);
        add(_textCreated);
        add(_titleArt);
        add(_textArt);
        add(_titleMusic);
        add(_textMusic);
        add(_btnBack);
        super.create();
    }

    function goMenu():Void {
        FlxG.switchState(new MenuState());
    }
}