package jammers.scenes;

import flash.geom.Rectangle;
import jammers.Library;
import jammers.scenes.Level;

class ClassRoom extends Level
{
    public function new(charOne : Int, charTwo : Int, modeOne : Int, modeTwo : Int)
    {
        super(Library.getInstance().classDisk, charOne, charTwo, modeOne, modeTwo);
        background.bitmapData = Library.getInstance().classBackground;
        foreground.bitmapData = Library.getInstance().classForeground;
        disk.zone = new Rectangle(-5, 18, 170, 112);
        playerOne.zone = new Rectangle(0, 18, 80, 112);
        playerTwo.zone = new Rectangle(81, 18, 80, 112);
    }
}