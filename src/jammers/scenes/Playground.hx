package jammers.scenes;

import flash.geom.Rectangle;
import flash.media.SoundChannel;
import flash.events.Event;
import jammers.Library;
import jammers.scenes.Level;

class Playground extends Level
{
    private var channel : SoundChannel;
    
    public function new()
    {
        super(Library.getInstance().playgroundDisk);
        background.bitmapData = Library.getInstance().playgroundBackground;
        foreground.bitmapData = Library.getInstance().playgroundForeground;
        disk.zone = new Rectangle(0, 18, 160, 112);
        playerOne.zone = new Rectangle(0, 18, 81, 112);
        playerTwo.zone = new Rectangle(80, 18, 81, 112);
        music();
    }
    
    public function music(?event : Event) : Void
    {
        if (channel != null) {
            channel.stop();
        }
        channel = Library.getInstance().musicOpening.play();
        channel.soundTransform.volume = 1;
        channel.addEventListener(Event.SOUND_COMPLETE, music);
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