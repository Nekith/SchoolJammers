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

class Player extends Sprite implements Entity
{
    public inline static var SPEED = 1.3;
    
    public var zone : Rectangle;
    private var level : Level;
    private var num : Int;
    private var size : Point;
    private var force : Point;
    private var isHolding : Bool;
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
        isHolding = false;
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
        force.x = 0;
        force.y = 0;
        if (isHolding == false) {
            if (num == 1) {
                if (true == level.keys[Keyboard.Q] || true == level.keys[Keyboard.A]) {
                    force.x -= SPEED;
                }
                if (true == level.keys[Keyboard.D]) {
                    force.x += SPEED;
                }
                if (true == level.keys[Keyboard.Z] || true == level.keys[Keyboard.W]) {
                    force.y -= SPEED;
                }
                if (true == level.keys[Keyboard.S]) {
                    force.y += SPEED;
                }
            } else {
                if (true == level.keys[Keyboard.LEFT]) {
                    force.x -= SPEED;
                }
                if (true == level.keys[Keyboard.RIGHT]) {
                    force.x += SPEED;
                }
                if (true == level.keys[Keyboard.UP]) {
                    force.y -= SPEED;
                }
                if (true == level.keys[Keyboard.DOWN]) {
                    force.y += SPEED;
                }
            }
            collision();
            disk();
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
        var rect : Rectangle = new Rectangle(x - size.x / 2, y - size.y / 2, size.x, size.y);
        if (rect.intersects(new Rectangle(level.disk.x - level.disk.size.x / 2, level.disk.y - level.disk.size.y / 2, level.disk.size.x, level.disk.size.y)) == true) {
            level.disk.force.x = 0;
            level.disk.force.y = 0;
            level.disk.y = y;
            if (num == 1) {
                level.disk.x = x + 11;
            } else {
                level.disk.x = x - 11;
            }
            isHolding = true;
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