package;

import flixel.*;

class Multiplayer extends FlxSprite {
    var _count:Float = 0;

    public function new() {
        super();
    }

    override public function update(e:Float):Void {

        _count += e;
        super.update(e);

        if (_count >= 1) {
            _count = 0;

            // FlxG.state.getPlayerById() ==
            var p = cast(FlxG.state, MultiplayerState).getPlayerById(1);

            if (p != null) {
                p.x += 5;
            }
        }
    }
}