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
    private var size : Point;
    private var num : Int;
    private var shadow : Bitmap;
    private var sprite : Bitmap;
    private var force : Point;
    private var anim : Int;
    
    public function new(number : Int)
    {
        super();
        zone = new Rectangle(0, 0, 0, 0);
        size = new Point(14, 20);
        num = number;
        shadow = new Bitmap(Library.getInstance().shadow);
        shadow.x = -12;
        shadow.y = -8;
        addChild(shadow);
        sprite = new Bitmap(new BitmapData(16, 24, true));
        sprite.x = -7;
        sprite.y = -21;
        addChild(sprite);
        force = new Point();
        anim = 0;
    }
    
    public function update(scene : Level) : Void
    {
        force.x = 0;
        force.y = 0;
        if (num == 1) {
            if (true == scene.keys[Keyboard.Q] || true == scene.keys[Keyboard.A]) {
                force.x -= SPEED;
            }
            if (true == scene.keys[Keyboard.D]) {
                force.x += SPEED;
            }
            if (true == scene.keys[Keyboard.Z] || true == scene.keys[Keyboard.W]) {
                force.y -= SPEED;
            }
            if (true == scene.keys[Keyboard.S]) {
                force.y += SPEED;
            }
        } else {
            if (true == scene.keys[Keyboard.LEFT]) {
                force.x -= SPEED;
            }
            if (true == scene.keys[Keyboard.RIGHT]) {
                force.x += SPEED;
            }
            if (true == scene.keys[Keyboard.UP]) {
                force.y -= SPEED;
            }
            if (true == scene.keys[Keyboard.DOWN]) {
                force.y += SPEED;
            }
        }
        collision();
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
    }
    
    public function clean() : Void
    {
        removeChild(shadow);
        removeChild(sprite);
    }
}