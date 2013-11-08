package jammers;

import flash.text.Font;
import flash.display.BitmapData;
import flash.media.Sound;

@:font("assets/visitor1.ttf") class PixelFont extends Font { }
@:bitmap("assets/gfx/title.png") class BitmapTitle extends BitmapData { }
@:bitmap("assets/gfx/title_space.png") class BitmapTitleSpace extends BitmapData { }
@:bitmap("assets/gfx/menu.png") class BitmapMenu extends BitmapData { }
@:bitmap("assets/gfx/players.png") class BitmapPlayers extends BitmapData { }
@:bitmap("assets/gfx/shadow.png") class BitmapShadow extends BitmapData { }
@:bitmap("assets/gfx/stun.png") class BitmapStun extends BitmapData { }
@:bitmap("assets/gfx/playground/background.png") class BitmapPlaygroundBackground extends BitmapData { }
@:bitmap("assets/gfx/playground/foreground.png") class BitmapPlaygroundForeground extends BitmapData { }
@:bitmap("assets/gfx/playground/disk.png") class BitmapPlaygroundDisk extends BitmapData { }
@:bitmap("assets/gfx/class/background.png") class BitmapClassBackground extends BitmapData { }
@:bitmap("assets/gfx/class/foreground.png") class BitmapClassForeground extends BitmapData { }
@:bitmap("assets/gfx/class/disk.png") class BitmapClassDisk extends BitmapData { }
@:sound("assets/sfx/title.mp3") class MusicTitle extends Sound { }
@:sound("assets/sfx/game.mp3") class MusicGame extends Sound { }
@:sound("assets/sfx/bounce.wav") class SoundBounce extends Sound { }
@:sound("assets/sfx/catch.wav") class SoundCatch extends Sound { }
@:sound("assets/sfx/stun.wav") class SoundStun extends Sound { }
@:sound("assets/sfx/throw.wav") class SoundThrow extends Sound { }
@:sound("assets/sfx/dash.wav") class SoundDash extends Sound { }
@:sound("assets/sfx/goal.wav") class SoundGoal extends Sound { }

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
        font = new PixelFont();
        title = new BitmapTitle(0, 0);
        titleSpace = new BitmapTitleSpace(0, 0);
        menu = new BitmapMenu(0, 0);
        players = new BitmapPlayers(0, 0);
        shadow = new BitmapShadow(0, 0);
        stun = new BitmapStun(0, 0);
        playgroundBackground = new BitmapPlaygroundBackground(0, 0);
        playgroundForeground = new BitmapPlaygroundForeground(0, 0);
        playgroundDisk = new BitmapPlaygroundDisk(0, 0);
        classBackground = new BitmapClassBackground(0, 0);
        classForeground = new BitmapClassForeground(0, 0);
        classDisk = new BitmapClassDisk(0, 0);
        musicTitle = new MusicTitle();
        musicGame = new MusicGame();
        soundBounce = new SoundBounce();
        soundCatch = new SoundCatch();
        soundStun = new SoundStun();
        soundThrow = new SoundThrow();
        soundDash = new SoundDash();
        soundGoal = new SoundGoal();
    }
}