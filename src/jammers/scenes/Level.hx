package jammers.scenes;

import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BitmapData;
import nekith.Scene;
import jammers.UserInterface;
import jammers.entities.Disk;
import jammers.entities.Player;

class Level extends Scene
{
    private var background : Bitmap;
    private var foreground : Bitmap;
    private var disk(default, null) : Disk;
    private var playerOne(default, null) : Player;
    
    private function new(diskBitmap : BitmapData)
    {
        super();
        dimension = new Point(180, 144);
        background = new Bitmap();
        background.x = -10;
        addChild(background);
        playerOne = new Player(1);
        playerOne.x = 32;
        playerOne.y = 32;
        addChild(playerOne);
        disk = new Disk(diskBitmap);
        disk.x = 32;
        disk.y = 32;
        addChild(disk);
        foreground = new Bitmap();
        foreground.x = -10;
        addChild(foreground);
    }
    
    public override function update() : Scene
    {
        super.update();
        if (true == focus) {
            disk.update(this);
            playerOne.update(this);
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