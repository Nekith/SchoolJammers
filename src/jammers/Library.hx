package jammers;

import flash.text.Font;
import flash.display.BitmapData;

@:font("assets/slkscr.ttf") class PixelFont extends Font { }
@:bitmap("assets/gfx/players.png") class BitmapPlayers extends BitmapData { }
@:bitmap("assets/gfx/shadow.png") class BitmapShadow extends BitmapData { }
@:bitmap("assets/gfx/playground/background.png") class BitmapPlaygroundBackground extends BitmapData { }
@:bitmap("assets/gfx/playground/foreground.png") class BitmapPlaygroundForeground extends BitmapData { }
@:bitmap("assets/gfx/playground/disk.png") class BitmapPlaygroundDisk extends BitmapData { }

class Library
{
    static private var instance : Library = null;
    
    public var font(default, null) : Font;
    public var players(default, null) : BitmapData;
    public var shadow(default, null) : BitmapData;
    public var playgroundBackground(default, null) : BitmapData;
    public var playgroundForeground(default, null) : BitmapData;
    public var playgroundDisk(default, null) : BitmapData;
    
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
    }
}