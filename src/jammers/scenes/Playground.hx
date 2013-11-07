package jammers.scenes;

import flash.geom.Rectangle;
import jammers.Library;
import jammers.scenes.Level;

class Playground extends Level
{
    public function new()
    {
        super(Library.getInstance().playgroundDisk);
        background.bitmapData = Library.getInstance().playgroundBackground;
        foreground.bitmapData = Library.getInstance().playgroundForeground;
        disk.zone = new Rectangle(0, 18, 160, 112);
        playerOne.zone = new Rectangle(0, 18, 81, 112);
        playerTwo.zone = new Rectangle(80, 18, 81, 112);
    }
}