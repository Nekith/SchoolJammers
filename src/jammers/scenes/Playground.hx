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
        playerOne.zone = new Rectangle(0, 18, 81, 112);
    }
    
    public override function draw() : Void
    {
        super.draw();
    }
    
    public override function clean() : Void
    {
        super.clean();
    }
}