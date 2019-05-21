package;

import flixel.*;

class Multiplayer extends FlxSprite {
    public static inline var OP_NOVO_JOGADOR:String = "n"; // [OP, ]
    public static inline var OP_MOVE:String = "m"; // [OP, _idJogador, x, y, x.velocity, y.velocity]

    var _count:Float = 0;
    var _idJogador:Int;

    public function new() {
        super();
        _idJogador = -1;
    }

    public function sendMsg(msg:Array<Any>) {
        // acoxambrando comuncacao
        onMsg(msg);
    }

    public function onMsg(msg:Array<Any>):Void {
        if (msg == null || msg.length == 0) {
            FlxG.log.error("Mensagem mal formada");
            return;
        }
        var op:String = msg[0];

        switch(op) {
            case OP_MOVE:
                trataMove(cast(msg[1], Int),
                           cast(msg[2], Int),
                           cast(msg[3], Int),
                           cast(msg[4], Float),
                           cast(msg[5], Float));
            default:
                FlxG.log.error("OP error: " + op);

        }
    }

    public function trataMove(idRemetente:Int, x:Int, y:Int, vx:Float, vy:Float):Void {
        if (idRemetente == _idJogador) {
            return;
        }
        
        var p = cast(FlxG.state, MultiplayerState).getPlayerById(idRemetente);

        if (p != null) {
            p.x = x;
            p.y = y;
            p.velocity.x = vx;
            p.velocity.y = vy;
        }
    }

    override public function update(e:Float):Void {

        _count += e;

        if (_count >= 1) {
            _count = 0;
            sendMsg([OP_MOVE, 2, 100, 150, 20, 20]);
            // sendMsg(null);
        }

        super.update(e);
    }
}