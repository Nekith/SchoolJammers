package jammers;

import flash.text.Font;
import flash.display.BitmapData;
import openfl.Assets;

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
        font = Assets.getFont("assets/slkscr.ttf");
        players = Assets.getBitmapData("assets/gfx/players.png");
        shadow = Assets.getBitmapData("assets/gfx/shadow.png");
        playgroundBackground = Assets.getBitmapData("assets/gfx/playground/background.png");
        playgroundForeground = Assets.getBitmapData("assets/gfx/playground/foreground.png");
        playgroundDisk = Assets.getBitmapData("assets/gfx/playground/disk.png");
    }
}