package jammers.entities;

import jammers.scenes.Level;

class Cpu extends Player
{
    private var waiting : Int;
    
    public function new(scene : Level, number : Int, character : Int)
    {
        super(scene, number, character);
        waiting = 0;
    }
    
    public override function update() : Void
    {
        var wantUp : Bool = false;
        var wantDown : Bool = false;
        var wantLeft : Bool = false;
        var wantRight : Bool = false;
        var wantMain : Bool = false;
        var wantSecond : Bool = false;
        if (holding > 30 && 0 == Std.random(3)) {
            var direction : Float = 0;
            var r : Int = Std.random(7);
            wantMain = true;
            if (r == 1) {
                wantUp = true;
                wantRight = true;
            } else if (r == 2) {
                wantUp = true;
                wantLeft = true;
            } else if (r == 3) {
                wantUp = true;
            } else if (r == 4) {
                wantDown = true;
                wantRight = true;
            } else if (r == 5) {
                wantDown = true;
                wantLeft = true;
            } else if (r == 6) {
                wantDown = true;
            }
            waiting = 30 + Std.random(30);
        } else if (waiting > 0) {
            --waiting;
        } else {
            var isDefending : Bool = false;
            if (level.disk.tossing >= 30) {
                isDefending = true;
            } else {
                if (num == 1) {
                    if (level.disk.force.x < 0 && level.disk.x <= zone.x) {
                        isDefending = true;
                    }
                } else {
                    if (level.disk.force.x > 0 && level.disk.x >= zone.x) {
                        isDefending = true;
                    }
                }
            }
            if (isDefending == true) {
                if (level.disk.tossing != 0) {
                    if (level.disk.x > x) {
                        wantRight = true;
                    } else if (level.disk.x < x) {
                        wantLeft = true;
                    }
                }
                if (level.disk.y > y) {
                    wantDown = true;
                } else if (level.disk.y < y) {
                    wantUp = true;
                }
            } else {
                if (num == 1) {
                    if (zone.x + zone.width / 2 < x) {
                        wantLeft = true;
                    }
                } else {
                    if (zone.x + zone.width / 2 > x) {
                        wantRight = true;
                    }
                }
                if (zone.y + zone.height / 2 > y + speedWalk) {
                    wantDown = true;
                } else if (zone.y + zone.height / 2 < y - speedWalk) {
                    wantUp = true;
                }
            }
        }
        dash(wantUp, wantDown, wantLeft, wantRight, wantSecond);
        movement(wantUp, wantDown, wantLeft, wantRight, wantMain);
        collision();
        disk(wantUp, wantDown, wantLeft, wantRight, wantMain, wantSecond);
    }
}