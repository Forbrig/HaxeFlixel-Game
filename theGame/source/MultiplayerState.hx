package;

import flixel.*;
import flixel.group.*;

class MultiplayerState extends FlxState {
    var _players:FlxGroup;
    var _multiplayer:Multiplayer;

    override public function create():Void {
        _players = new FlxGroup();

        _players.add(new PlayerM(1, W, S, A, D));
        _players.add(new PlayerM(2, UP, DOWN, LEFT, RIGHT));
        add(_players);
        add(_multiplayer = new Multiplayer());


        super.create();
    }

    override public function update(elapsed:Float):Void {
        // FlxG.log.add(getPlayerById(1)._id);
        super.update(elapsed);
    }

    public function getPlayerById(id:Int):PlayerM {
        for (p in _players) {
            if (cast(p, PlayerM)._id == id) {
                return cast(p, PlayerM);
            }
        }
        return null;
    }
}