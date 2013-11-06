package jammers.scenes;

import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import nekith.Scene;
import jammers.UserInterface;
import jammers.entities.Disk;
import jammers.entities.Player;

class Level extends Scene
{
    public var shadows : Sprite;
    public var disk(default, null) : Disk;
    public var playerOne(default, null) : Player;
    private var background : Bitmap;
    private var foreground : Bitmap;
    
    private function new(diskBitmap : BitmapData)
    {
        super();
        dimension = new Point(180, 144);
        shadows = new Sprite();
        disk = new Disk(this, diskBitmap);
        disk.x = 120;
        disk.y = 60;
        playerOne = new Player(this, 1);
        playerOne.x = 32;
        playerOne.y = 32;
        background = new Bitmap();
        background.x = -10;
        foreground = new Bitmap();
        foreground.x = -10;
        addChild(background);
        addChild(shadows);
        addChild(disk);
        addChild(playerOne);
        addChild(foreground);
    }
    
    public override function update() : Scene
    {
        super.update();
        if (true == focus) {
            disk.update();
            playerOne.update();
        }
        return this;
    }
    
    public override function draw() : Void
    {
        super.draw();
        if (true == focus) {
            disk.draw();
            playerOne.draw();
        }
    }
    
    public override function clean() : Void
    {
        super.clean();
        disk.clean();
        playerOne.clean();
        removeChild(background);
        removeChild(playerOne);
        removeChild(disk);
        removeChild(foreground);
    }
}