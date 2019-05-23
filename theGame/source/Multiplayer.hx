package;

import flixel.*;

class Multiplayer extends FlxSprite {
    public static inline var OP_NOVO_JOGADOR:String = "n"; // [OP, ]
    public static inline var OP_MOVE:String = "m"; // [OP, _idJogador, x, y, x.velocity, y.velocity]
    public static inline var OP_TIRO:String = "t"; // [OP, _idJogador, xp, yp]

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

    // retorna true se precisa processar a mensagem
    function confereRemetente(idRemetente:Int):Bool {
         if (idRemetente == _idJogador) {
            return false;
        }
        
        var p = cast(FlxG.state, MultiplayerState).getPlayerById(idRemetente);        

        if (p == null) {
            cast(FlxG.state, MultiplayerState).players.add(new PlayerM(idRemetente));
        }

        return true;
    }

    public function onMsg(msg:Array<Any>):Void {
        if (msg == null || msg.length == 0) {
            FlxG.log.error("Mensagem mal formada");
            return;
        }

        var op:String = msg[0];
        var idRemetente:Int = cast(msg[1], Int);
        var deveProcessarMsg = confereRemetente(idRemetente);

        if (!deveProcessarMsg) {
            return;
        }

        switch(op) {
            case OP_MOVE:
                trataMove(idRemetente,
                           cast(msg[2], Int),
                           cast(msg[3], Int),
                           cast(msg[4], Float),
                           cast(msg[5], Float));
            case OP_TIRO:
                trataTiro(idRemetente,
                           cast(msg[2], Int),
                           cast(msg[3], Int));
            default:
                FlxG.log.error("OP error: " + op);

        }
    }

    public function trataMove(idRemetente:Int, x:Int, y:Int, vx:Float, vy:Float):Void {
        var p = cast(FlxG.state, MultiplayerState).getPlayerById(idRemetente);

        if (p != null) {
            p.x = x;
            p.y = y;
            p.velocity.x = vx;
            p.velocity.y = vy;
        }
    }

    public function trataTiro(idRemetente:Int, x:Int, y:Int):Void {
        var state:MultiplayerState = cast(FlxG.state, MultiplayerState);

        var p = state.getPlayerById(idRemetente);

        if (p == null) {
            return;
        }

        p.x = x;
        p.y = y;
        state.atira(x, y);
    }

    override public function update(e:Float):Void {

        _count += e;

        if (_count >= 3) {
            _count = 0;
            sendMsg([OP_MOVE, 1, 100, 150, 20, 20]);
            sendMsg([OP_MOVE, 2, 100, 150, 0, 20]);
            sendMsg([OP_MOVE, 3, 100, 150, 0, 80]);
            sendMsg([OP_MOVE, 4, 100, 150, 80, 80]);
            sendMsg([OP_TIRO, 4, 100, 150]);
            // sendMsg(null);
        }

        

        super.update(e);
    }
}