package jammers;

import flash.text.Font;
import flash.display.BitmapData;
import flash.media.Sound;

@:font("assets/slkscr.ttf") class PixelFont extends Font { }
@:bitmap("assets/gfx/players.png") class BitmapPlayers extends BitmapData { }
@:bitmap("assets/gfx/shadow.png") class BitmapShadow extends BitmapData { }
@:bitmap("assets/gfx/playground/background.png") class BitmapPlaygroundBackground extends BitmapData { }
@:bitmap("assets/gfx/playground/foreground.png") class BitmapPlaygroundForeground extends BitmapData { }
@:bitmap("assets/gfx/playground/disk.png") class BitmapPlaygroundDisk extends BitmapData { }
@:sound("assets/sfx/opening.wav") class MusicOpening extends Sound { }
@:sound("assets/sfx/bounce.wav") class SoundBounce extends Sound { }
@:sound("assets/sfx/catch.wav") class SoundCatch extends Sound { }
@:sound("assets/sfx/throw.wav") class SoundThrow extends Sound { }
@:sound("assets/sfx/dash.wav") class SoundDash extends Sound { }

class Library
{
    static private var instance : Library = null;
    
    public var font(default, null) : Font;
    public var players(default, null) : BitmapData;
    public var shadow(default, null) : BitmapData;
    public var playgroundBackground(default, null) : BitmapData;
    public var playgroundForeground(default, null) : BitmapData;
    public var playgroundDisk(default, null) : BitmapData;
    public var musicOpening(default, null) : Sound;
    public var soundBounce(default, null) : Sound;
    public var soundCatch(default, null) : Sound;
    public var soundThrow(default, null) : Sound;
    public var soundDash(default, null) : Sound;
    
    static public function getInstance() : Library
    {
        if (instance == null) {
            instance = new Library();
        }
        return instance;
    }
    
    private function new()
    {
        font = new PixelFont();
        players = new BitmapPlayers(0, 0);
        shadow = new BitmapShadow(0, 0);
        playgroundBackground = new BitmapPlaygroundBackground(0, 0);
        playgroundForeground = new BitmapPlaygroundForeground(0, 0);
        playgroundDisk = new BitmapPlaygroundDisk(0, 0);
        musicOpening = new MusicOpening();
        soundBounce = new SoundBounce();
        soundCatch = new SoundCatch();
        soundThrow = new SoundThrow();
        soundDash = new SoundDash();
    }
}