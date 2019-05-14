package;

import flixel.*;

class SteeringBehavior extends FlxState {
    override public function create():Void {
        add(new Boid());

        
    }
}