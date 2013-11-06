package jammers.entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.ui.Keyboard;
import nekith.Entity;
import jammers.Library;
import jammers.scenes.Level;
import jammers.entities.Disk;

class Player extends Sprite implements Entity
{
    public inline static var SPEED_WALK = 1.2;
    public inline static var SPEED_DASH = 2.3;
    
    public var zone : Rectangle;
    private var level : Level;
    private var num : Int;
    private var size : Point;
    private var force : Point;
    private var holding : Int;
    private var dashing : Int;
    private var shadow : Bitmap;
    private var sprite : Bitmap;
    private var anim : Int;
    
    public function new(scene : Level, number : Int)
    {
        super();
        zone = new Rectangle(0, 0, 0, 0);
        level = scene;
        num = number;
        size = new Point(14, 20);
        force = new Point();
        holding = 0;
        dashing = 0;
        shadow = new Bitmap(Library.getInstance().shadow);
        shadow.x = -12;
        shadow.y = -8;
        level.shadows.addChild(shadow);
        sprite = new Bitmap(new BitmapData(16, 24, true));
        sprite.x = -7;
        sprite.y = -21;
        addChild(sprite);
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
        } else if (holding == 0) {
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
                        force = Point.polar(SPEED_DASH, direction);
                        dashing = 20;
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
                        force = Point.polar(SPEED_DASH, direction);
                        dashing = 20;
                    }
                }
            }
        }
    }
    
    private function movement() : Void
    {
        if (dashing == 0) {
            force.x = 0;
            force.y = 0;
            if (holding == 0) {
                if (num == 1) {
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
                        force = Point.polar(SPEED_WALK, direction);
                    }
                } else {
                    var direction : Float = -1;
                    if (true == level.keys[Keyboard.LEFT]) {
                        direction = Math.PI;
                    } else if (true == level.keys[Keyboard.LEFT] && true == level.keys[Keyboard.UP]) {
                        direction = 5 * Math.PI / 4;
                    } else if (true == level.keys[Keyboard.UP]) {
                        direction = -Math.PI / 2;
                    } else if (true == level.keys[Keyboard.UP] && true == level.keys[Keyboard.RIGHT]) {
                        direction = -Math.PI / 4;
                    } else if (true == level.keys[Keyboard.RIGHT]) {
                        direction = 0;
                    } else if (true == level.keys[Keyboard.RIGHT] && true == level.keys[Keyboard.DOWN]) {
                        direction = Math.PI / 4;
                    } else if (true == level.keys[Keyboard.DOWN]) {
                        direction = Math.PI / 2;
                    } else if (true == level.keys[Keyboard.DOWN] && true == level.keys[Keyboard.LEFT]) {
                        direction = 3 * Math.PI / 4;
                    }
                    if (direction != -1) {
                        force = Point.polar(SPEED_WALK, direction);
                    }
                }
            }
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
        if (holding == 0) {
            var rect : Rectangle = new Rectangle(x - size.x / 2, y - size.y / 2, size.x, size.y);
            if (rect.intersects(new Rectangle(level.disk.x - level.disk.size.x / 2, level.disk.y - level.disk.size.y / 2, level.disk.size.x, level.disk.size.y)) == true) {
                hold();
                holding = 6;
            }
        } else if (dashing == 0) {
            if (holding == 6) {
                if (num == 1) {
                    if (true == level.keys[Keyboard.T]) {
                        var direction : Float = 0;
                        if (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) {
                            direction = -Math.PI / 4;
                        } else if (true == level.keys[Keyboard.S]) {
                            direction = Math.PI / 4;
                        }
                        --holding;
                        level.disk.speed += Disk.SPEED_INCREASE;
                        level.disk.force = Point.polar(level.disk.speed, direction);
                    }
                } else {
                    if (true == level.keys[Keyboard.NUMPAD_7] || true == level.keys[Keyboard.O]) {
                        var direction : Float = Math.PI;
                        if (true == level.keys[Keyboard.UP]) {
                            direction = 3 * Math.PI / 4;
                        } else if (true == level.keys[Keyboard.DOWN]) {
                            direction = 5 * Math.PI / 4;
                        }
                        --holding;
                        level.disk.speed += Disk.SPEED_INCREASE;
                        level.disk.force = Point.polar(level.disk.speed, direction);
                    }
                }
            } else {
                --holding;
            }
        }
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
        sprite.bitmapData.copyPixels(Library.getInstance().players, new Rectangle(vx, vy, 16, 24), new Point(0, 0));
        shadow.x = x - 12;
        shadow.y = y - 8;
    }
    
    public function clean() : Void
    {
        level.shadows.removeChild(shadow);
        removeChild(sprite);
    }
}