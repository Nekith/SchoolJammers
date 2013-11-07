package jammers.entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import nekith.Entity;
import jammers.Library;
import jammers.scenes.Level;

class Disk extends Sprite implements Entity
{
    public inline static var SPEED_NORMAL = 1.5;
    public inline static var SPEED_TOSS = 1.5;
    public inline static var SPEED_INCREASE = 0.17;
    
    public var zone : Rectangle;
    public var size(default, null) : Point;
    public var speed : Float;
    public var force : Point;
    public var tossing(default, null) : Int;
    private var level : Level;
    private var sheet : BitmapData;
    private var shadow : Bitmap;
    private var sprite : Bitmap;
    private var anim : Int;
    
    public function new(scene : Level, diskBitmap : BitmapData)
    {
        super();
        zone = new Rectangle();
        size = new Point(16, 10);
        speed = SPEED_NORMAL;
        force = Point.polar(speed, Math.PI / 4);
        tossing = 0;
        level = scene;
        sheet = diskBitmap;
        shadow = new Bitmap(new BitmapData(16, 10, true));
        shadow.bitmapData.copyPixels(sheet, new Rectangle(0, 20, 16, 10), new Point(0, 0));
        shadow.x = -8;
        shadow.y = -5;
        level.shadows.addChild(shadow);
        sprite = new Bitmap(new BitmapData(16, 10, true));
        sprite.x = -8;
        sprite.y = -11;
        addChild(sprite);
        anim = 0;
    }
    
    public function update() : Void
    {
        x += force.x;
        y += force.y;
        if (x - size.x / 2 < zone.x) {
            level.goal(2);
        } else if (x + size.x / 2 > zone.x + zone.width) {
            level.goal(1);
        }
        if (y - size.y / 2 < zone.y) {
            y = zone.y + size.y / 2;
            force.y = -force.y;
            Library.getInstance().soundBounce.play();
        } else if (y + size.y / 2 > zone.y + zone.height) {
            y = zone.y + zone.height - size.y / 2;
            force.y = -force.y;
            Library.getInstance().soundBounce.play();
        }
        if (tossing != 0) {
            --tossing;
            if (tossing == 0) {
            }
        }
    }
    
    public function toss(direction : Float) : Void
    {
        level.disk.speed = Disk.SPEED_TOSS;
        level.disk.tossing = 60;
        force = Point.polar(speed, direction);
    }
    
    public function normalThrow(direction : Float) : Void
    {
        speed += Disk.SPEED_INCREASE;
        force = Point.polar(speed, direction);
    }
    
    public function draw() : Void
    {
        if (force.x != 0 || force.y != 0) {
            var vy : Int = 0;
            ++anim;
            if (anim >= 30) {
                vy = 0;
                anim = 0;
            } else if (anim >= 15) {
                vy = 10;
            }
            sprite.bitmapData.copyPixels(sheet, new Rectangle(0, vy, 16, 10), new Point(0, 0));
        }
        if (tossing != 0) {
            if (tossing > 40) {
                sprite.y = -11 + tossing % 21 - 20;
            } else if (tossing > 20) {
                sprite.y = -31;
            } else {
                sprite.y = -11 - tossing;
            }
        } else {
            sprite.y = -11;
        }
        shadow.x = x - 8;
        shadow.y = y - 5;
    }
    
    public function clean() : Void
    {
        level.shadows.removeChild(shadow);
        removeChild(sprite);
    }
}