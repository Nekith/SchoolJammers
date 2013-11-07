package jammers.entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.geom.ColorTransform;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.BlendMode;
import flash.ui.Keyboard;
import nekith.Entity;
import jammers.Library;
import jammers.scenes.Level;
import jammers.entities.Disk;

class Player extends Sprite implements Entity
{
    public var zone : Rectangle;
    public var force : Point;
    public var speedWalk(default, null) : Float;
    public var speedDash(default, null) : Float;
    public var strength(default, null) : Float;
    private var level : Level;
    private var num : Int;
    private var char : Int;
    private var size : Point;
    private var holding : Int;
    private var dashing : Int;
    private var stunned : Int;
    private var charging : Int;
    private var shadow : Bitmap;
    private var sprite : Bitmap;
    private var stunEffect : Bitmap;
    private var anim : Int;
    
    public function new(scene : Level, number : Int, character : Int)
    {
        super();
        zone = new Rectangle(0, 0, 0, 0);
        force = new Point();
        if (char == 3) {
            speedWalk = 1.1;
            speedDash = 2.1;
            strength = 3.9;
        } else if (char == 2) {
            speedWalk = 1.3;
            speedDash = 2.5;
            strength = 3.1;
        } else {
            speedWalk = 1.2;
            speedDash = 2.3;
            strength = 3.5;
        }
        level = scene;
        num = number;
        char = character;
        size = new Point(14, 20);
        holding = 0;
        dashing = 0;
        stunned = 0;
        charging = 0;
        shadow = new Bitmap(Library.getInstance().shadow);
        shadow.x = -12;
        shadow.y = -8;
        level.shadows.addChild(shadow);
        sprite = new Bitmap(new BitmapData(16, 24, true));
        sprite.x = -7;
        sprite.y = -21;
        addChild(sprite);
        stunEffect = new Bitmap(new BitmapData(16, 16, true));
        stunEffect.x = -8;
        stunEffect.y = -28;
        stunEffect.alpha = 0;
        addChild(stunEffect);
        anim = 0;
    }
    
    public function update() : Void
    {
        dash();
        movement();
        collision();
        disk();
    }
    
    private function dash() : Void
    {
        if (dashing != 0) {
            --dashing;
            if (holding != 0) {
                hold();
            }
        } else if (holding == 0 && stunned == 0) {
            if (num == 1) {
                if (true == level.keys[Keyboard.Y]) {
                    var direction : Float = -1;
                    if ((true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) && (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W])) {
                        direction = 5 * Math.PI / 4;
                    } else if ((true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) && true == level.keys[Keyboard.D]) {
                        direction = -Math.PI / 4;
                    } else if (true == level.keys[Keyboard.D] && true == level.keys[Keyboard.S]) {
                        direction = Math.PI / 4;
                    } else if (true == level.keys[Keyboard.S] && (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A])) {
                        direction = 3 * Math.PI / 4;
                    } else if (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) {
                        direction = Math.PI;
                    } else if (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) {
                        direction = -Math.PI / 2;
                    } else if (true == level.keys[Keyboard.D]) {
                        direction = 0;
                    } else if (true == level.keys[Keyboard.S]) {
                        direction = Math.PI / 2;
                    }
                    if (direction != -1) {
                        force = Point.polar(speedDash, direction);
                        dashing = 20;
                        Library.getInstance().soundDash.play();
                    }
                }
            } else {
                if (true == level.keys[Keyboard.NUMPAD_8] || true == level.keys[Keyboard.P]) {
                    var direction : Float = -1;
                    if (true == level.keys[Keyboard.LEFT] && true == level.keys[Keyboard.UP]) {
                        direction = 5 * Math.PI / 4;
                    } else if (true == level.keys[Keyboard.UP] && true == level.keys[Keyboard.RIGHT]) {
                        direction = -Math.PI / 4;
                    } else if (true == level.keys[Keyboard.RIGHT] && true == level.keys[Keyboard.DOWN]) {
                        direction = Math.PI / 4;
                    } else if (true == level.keys[Keyboard.DOWN] && true == level.keys[Keyboard.LEFT]) {
                        direction = 3 * Math.PI / 4;
                    } else if (true == level.keys[Keyboard.LEFT]) {
                        direction = Math.PI;
                    } else if (true == level.keys[Keyboard.UP]) {
                        direction = -Math.PI / 2;
                    } else if (true == level.keys[Keyboard.RIGHT]) {
                        direction = 0;
                    } else if (true == level.keys[Keyboard.DOWN]) {
                        direction = Math.PI / 2;
                    }
                    if (direction != -1) {
                        force = Point.polar(speedDash, direction);
                        dashing = 20;
                        Library.getInstance().soundDash.play();
                    }
                }
            }
        }
    }
    
    private function movement() : Void
    {
        if (dashing == 0 && level.breakTime == 0) {
            force.x = 0;
            force.y = 0;
            if (holding == 0 && stunned == 0) {
                if (num == 1) {
                    if (false == level.keys[Keyboard.T]) {
                        var direction : Float = -1;
                        if ((true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) && (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W])) {
                            direction = 5 * Math.PI / 4;
                        } else if ((true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) && true == level.keys[Keyboard.D]) {
                            direction = -Math.PI / 4;
                        } else if (true == level.keys[Keyboard.D] && true == level.keys[Keyboard.S]) {
                            direction = Math.PI / 4;
                        } else if (true == level.keys[Keyboard.S] && (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A])) {
                            direction = 3 * Math.PI / 4;
                        } else if (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) {
                            direction = Math.PI;
                        } else if (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) {
                            direction = -Math.PI / 2;
                        } else if (true == level.keys[Keyboard.D]) {
                            direction = 0;
                        } else if (true == level.keys[Keyboard.S]) {
                            direction = Math.PI / 2;
                        }
                        if (direction != -1) {
                            force = Point.polar(speedWalk, direction);
                            charging = 0;
                        }
                    }
                } else {
                    if (false == level.keys[Keyboard.NUMPAD_7] && false == level.keys[Keyboard.O]) {
                        var direction : Float = -1;
                        if (true == level.keys[Keyboard.LEFT] && true == level.keys[Keyboard.UP]) {
                            direction = 5 * Math.PI / 4;
                        } else if (true == level.keys[Keyboard.UP] && true == level.keys[Keyboard.RIGHT]) {
                            direction = -Math.PI / 4;
                        } else if (true == level.keys[Keyboard.RIGHT] && true == level.keys[Keyboard.DOWN]) {
                            direction = Math.PI / 4;
                        } else if (true == level.keys[Keyboard.DOWN] && true == level.keys[Keyboard.LEFT]) {
                            direction = 3 * Math.PI / 4;
                        } else if (true == level.keys[Keyboard.LEFT]) {
                            direction = Math.PI;
                        } else if (true == level.keys[Keyboard.UP]) {
                            direction = -Math.PI / 2;
                        } else if (true == level.keys[Keyboard.RIGHT]) {
                            direction = 0;
                        } else if (true == level.keys[Keyboard.DOWN]) {
                            direction = Math.PI / 2;
                        }
                        if (direction != -1) {
                            force = Point.polar(speedWalk, direction);
                            charging = 0;
                        }
                    }
                }
            }
        }
        if (stunned != 0) {
            --stunned;
            charging = 0;
        }
    }
    
    private function collision() : Void
    {
        x += force.x;
        y += force.y;
        if (x - size.x / 2 < zone.x) {
            x = zone.x + size.x / 2;
        } else if (x + size.x / 2 > zone.x + zone.width) {
            x = zone.x + zone.width - size.x / 2;
        }
        if (y - size.y / 2 < zone.y) {
            y = zone.y + size.y / 2;
        } else if (y + size.y / 2 > zone.y + zone.height) {
            y = zone.y + zone.height - size.y / 2;
        }
    }
    
    private function disk() : Void
    {
        if (holding == 0 && stunned == 0) {
            if (num == 1 && true == level.keys[Keyboard.T]) {
                ++charging;
            } else if (num == 2 && (true == level.keys[Keyboard.NUMPAD_7] || true == level.keys[Keyboard.O])) {
                ++charging;
            }
            if (level.disk.tossing < 10 && level.disk.tossing >= 0) {
                var rect : Rectangle = new Rectangle(x - size.x / 2, y - size.y / 2, size.x, size.y);
                if (rect.intersects(new Rectangle(level.disk.x - level.disk.size.x / 2, level.disk.y - level.disk.size.y / 2, level.disk.size.x, level.disk.size.y)) == true) {
                    if (level.disk.speed >= strength && charging < 30) {
                        stun();
                    } else {
                        if (level.disk.tossing == 0 && level.disk.speed < strength) {
                            charging = 0;
                        }
                        hold();
                        holding = 6;
                        level.disk.tossing = 0;
                        Library.getInstance().soundCatch.play();
                    }
                }
            }
        } else if (dashing == 0 && level.breakTime == 0 && stunned == 0) {
            if (holding >= 6) {
                if (num == 1) {
                    if (holding >= 120 || true == level.keys[Keyboard.T] || true == level.keys[Keyboard.Y]) {
                        var direction : Float = 0;
                        if (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) {
                            if (true == level.keys[Keyboard.D]) {
                                direction = -Math.PI / 6;
                            } else if (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) {
                                direction = -Math.PI / 3;
                            } else {
                                direction = -Math.PI / 4;
                            }
                        } else if (true == level.keys[Keyboard.S]) {
                            if (true == level.keys[Keyboard.D]) {
                                direction = Math.PI / 6;
                            } else if (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) {
                                direction = Math.PI / 3;
                            } else {
                                direction = Math.PI / 4;
                            }
                        }
                        holding = 5;
                        if (true == level.keys[Keyboard.Y]) {
                            level.disk.toss(direction);
                        } else if (charging >= 30) {
                            level.disk.powerThrow(direction, strength);
                        } else {
                            level.disk.normalThrow(direction);
                        }
                        charging = 0;
                        Library.getInstance().soundThrow.play();
                    } else {
                        ++holding;
                    }
                } else {
                    if (holding >= 120 || true == level.keys[Keyboard.NUMPAD_7] || true == level.keys[Keyboard.O] || true == level.keys[Keyboard.NUMPAD_8] || true == level.keys[Keyboard.P]) {
                        var direction : Float = Math.PI;
                        if (true == level.keys[Keyboard.UP]) {
                            if (true == level.keys[Keyboard.RIGHT]) {
                                direction = -2 * Math.PI / 3;
                            } else if (true == level.keys[Keyboard.LEFT]) {
                                direction = -5 * Math.PI / 6;
                            } else {
                                direction = -3 * Math.PI / 4;
                            }
                        } else if (true == level.keys[Keyboard.DOWN]) {
                            if (true == level.keys[Keyboard.RIGHT]) {
                                direction = 4 * Math.PI / 3;
                            } else if (true == level.keys[Keyboard.LEFT]) {
                                direction = 7 * Math.PI / 6;
                            } else {
                                direction = 5 * Math.PI / 4;
                            }
                        }
                        holding = 5;
                        if (true == level.keys[Keyboard.NUMPAD_8] || true == level.keys[Keyboard.P]) {
                            level.disk.toss(direction);
                        } else if (charging >= 30) {
                            level.disk.powerThrow(direction, strength);
                        } else {
                            level.disk.normalThrow(direction);
                        }
                        charging = 0;
                        Library.getInstance().soundThrow.play();
                    } else {
                        ++holding;
                    }
                }
            } else {
                --holding;
            }
        }
    }
    
    private function stun() : Void
    {
        if (num == 1) {
            level.disk.toss(0);
        } else {
            level.disk.toss(Math.PI);
        }
        stunned = 70;
        Library.getInstance().soundStun.play();
    }
    
    private function hold() : Void
    {
        level.disk.force.x = 0;
        level.disk.force.y = 0;
        level.disk.y = y;
        if (num == 1) {
            level.disk.x = x + 11;
        } else {
            level.disk.x = x - 11;
        }
    }
    
    public function stop() : Void
    {
        force.x = 0;
        force.y = 0;
        holding = 0;
        dashing = 0;
        stunned = 0;
    }
    
    public function draw() : Void
    {
        var vx : Int = 0;
        var vy : Int = 0;
        if (force.x > 0) {
            vy = 24;
        } else if (force.x < 0) {
            vy = 48;
        } else if (force.y > 0) {
            vy = 96;
        } else if (force.y < 0) {
            vy = 72;
        }
        ++anim;
        if (force.x == 0 && force.y == 0) {
            vx = 0;
        } else if (anim >= 30) {
            vx = 0;
            anim = 0;
        } else if (anim >= 15) {
            vx = 16;
        }
        if (stunned != 0) {
            stunEffect.alpha = 1;
            stunEffect.bitmapData.copyPixels(Library.getInstance().stun, new Rectangle(0, (anim % 20 >= 10 ? 16 : 0), 16, 16), new Point(0, 0));
        } else {
            stunEffect.alpha = 0;
        }
        if (char == 2) {
            vx += 32;
        } else if (char == 3) {
            vx += 64;
        }
        if (num == 2) {
            var temp : BitmapData = new BitmapData(16, 24, true, 0);
            temp.copyPixels(Library.getInstance().players, new Rectangle(vx, vy, 16, 24), new Point(0, 0));
            var matrix : Matrix = new Matrix();
            matrix.scale( -1, 1);
            matrix.translate(16, 0);
            sprite.bitmapData = new BitmapData(16, 24, true, 0);
            sprite.bitmapData.draw(temp, matrix);
        } else {
            sprite.bitmapData.copyPixels(Library.getInstance().players, new Rectangle(vx, vy, 16, 24), new Point(0, 0));
        }
        shadow.x = x - 12;
        shadow.y = y - 8;
    }
    
    public function clean() : Void
    {
        level.shadows.removeChild(shadow);
        removeChild(sprite);
        removeChild(stunEffect);
    }
}