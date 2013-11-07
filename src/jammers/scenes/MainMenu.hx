package jammers.scenes;

import flash.display.Bitmap;
import flash.events.Event;
import flash.ui.Keyboard;
import flash.media.SoundChannel;
import nekith.Scene;
import jammers.Library;

class MainMenu extends Scene
{
    private var background : Bitmap;
    private var space : Bitmap;
    private var channel : SoundChannel;
    private var anim : Int;
    
    public function new()
    {
        super();
        background = new Bitmap(Library.getInstance().title);
        space = new Bitmap(Library.getInstance().titleSpace);
        addChild(background);
        addChild(space);
        anim = 0;
        music();
    }
    
    public function music(?event : Event) : Void
    {
        if (channel != null) {
            channel.stop();
        }
        channel = Library.getInstance().musicTitle.play();
        channel.soundTransform.volume = 1;
        channel.addEventListener(Event.SOUND_COMPLETE, music);
    }
    
    public override function update() : Scene
    {
        if (true == keys[Keyboard.SPACE]) {
            return new Playground();
        }
        return this;
    }
    
    public override function draw() : Void
    {
        super.draw();
        ++anim;
        if (anim >= 90) {
            space.alpha = 1;
            anim = 0;
        } else if (anim >= 45) {
            space.alpha = 0;
        }
    }
    
    public override function clean() : Void
    {
        super.clean();
        removeChild(background);
        removeChild(space);
        channel.stop();
    }
}