package jammers;

import flash.text.Font;
import flash.display.BitmapData;
import flash.media.Sound;
import openfl.Assets;

class Library
{
    static private var instance : Library = null;
    
    public var font(default, null) : Font;
    public var title(default, null) : BitmapData;
    public var titleSpace(default, null) : BitmapData;
    public var menu(default, null) : BitmapData;
    public var players(default, null) : BitmapData;
    public var shadow(default, null) : BitmapData;
    public var stun(default, null) : BitmapData;
    public var playgroundBackground(default, null) : BitmapData;
    public var playgroundForeground(default, null) : BitmapData;
    public var playgroundDisk(default, null) : BitmapData;
    public var classBackground(default, null) : BitmapData;
    public var classForeground(default, null) : BitmapData;
    public var classDisk(default, null) : BitmapData;
    public var musicTitle(default, null) : Sound;
    public var musicGame(default, null) : Sound;
    public var soundBounce(default, null) : Sound;
    public var soundCatch(default, null) : Sound;
    public var soundStun(default, null) : Sound;
    public var soundThrow(default, null) : Sound;
    public var soundDash(default, null) : Sound;
    public var soundGoal(default, null) : Sound;
    
    static public function getInstance() : Library
    {
        if (instance == null) {
            instance = new Library();
        }
        return instance;
    }
    
    private function new()
    {
        font = Assets.getFont("assets/visitor1.ttf");
        title = Assets.getBitmapData("assets/gfx/title.png");
        titleSpace = Assets.getBitmapData("assets/gfx/title_space.png");
        menu = Assets.getBitmapData("assets/gfx/menu.png");
        players = Assets.getBitmapData("assets/gfx/players.png");
        shadow = Assets.getBitmapData("assets/gfx/shadow.png");
        stun = Assets.getBitmapData("assets/gfx/stun.png");
        playgroundBackground = Assets.getBitmapData("assets/gfx/playground/background.png");
        playgroundForeground = Assets.getBitmapData("assets/gfx/playground/foreground.png");
        playgroundDisk = Assets.getBitmapData("assets/gfx/playground/disk.png");
        classBackground = Assets.getBitmapData("assets/gfx/class/background.png");
        classForeground = Assets.getBitmapData("assets/gfx/class/foreground.png");
        classDisk = Assets.getBitmapData("assets/gfx/class/disk.png");
        musicTitle = Assets.getSound("assets/sfx/title.mp3");
        musicGame = Assets.getSound("assets/sfx/game.mp3");
        soundBounce = Assets.getSound("assets/sfx/bounce.wav");
        soundCatch = Assets.getSound("assets/sfx/catch.wav");
        soundStun = Assets.getSound("assets/sfx/stun.wav");
        soundThrow = Assets.getSound("assets/sfx/throw.wav");
        soundDash = Assets.getSound("assets/sfx/dash.wav");
        soundGoal = Assets.getSound("assets/sfx/goal.wav");
    }
}