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
    private var sheet : BitmapData;
    private var shadow : Bitmap;
    private var sprite : Bitmap;
    private var anim : Int;
    
    public function new(diskBitmap : BitmapData)
    {
        super();
        sheet = diskBitmap;
        shadow = new Bitmap(new BitmapData(16, 10, true));
        shadow.bitmapData.copyPixels(sheet, new Rectangle(0, 20, 16, 10), new Point(0, 0));
        shadow.x = -8;
        shadow.y = -5;
        addChild(shadow);
        sprite = new Bitmap(new BitmapData(16, 10, true));
        sprite.x = -8;
        sprite.y = -15;
        addChild(sprite);
        anim = 0;
    }
    
    public function update(scene : Level) : Void
    {
    }
    
    public function draw() : Void
    {
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
    
    public function clean() : Void
    {
        removeChild(shadow);
        removeChild(sprite);
    }
}