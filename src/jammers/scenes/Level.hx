package jammers.scenes;

import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.media.SoundChannel;
import flash.events.Event;
import nekith.Scene;
import jammers.Library;
import jammers.UserInterface;
import jammers.entities.Disk;
import jammers.entities.Player;

class Level extends Scene
{
    public var shadows : Sprite;
    public var disk(default, null) : Disk;
    public var playerOne(default, null) : Player;
    public var playerTwo(default, null) : Player;
    public var breakTime(default, null) : Int;
    private var background : Bitmap;
    private var foreground : Bitmap;
    private var scoreOne : TextField;
    private var scoreTwo : TextField;
    private var channel : SoundChannel;
    
    private function new(diskBitmap : BitmapData)
    {
        super();
        dimension = new Point(180, 144);
        shadows = new Sprite();
        breakTime = 0;
        // disk
        disk = new Disk(this, diskBitmap);
        disk.x = 120;
        disk.y = 60;
        // playerOne
        playerOne = new Player(this, 1);
        playerOne.x = 10;
        playerOne.y = 73;
        // playerTwo
        playerTwo = new Player(this, 2);
        playerTwo.x = 150;
        playerTwo.y = 73;
        // background
        background = new Bitmap();
        background.x = -10;
        // foreground
        foreground = new Bitmap();
        foreground.x = -10;
        // scoreOne
        var tfOne : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfOne.align = TextFormatAlign.RIGHT;
        scoreOne = new TextField();
        scoreOne.embedFonts = true;
        scoreOne.defaultTextFormat = tfOne;
        scoreOne.selectable = false;
        scoreOne.text = "0";
        scoreOne.x = 43;
        scoreOne.y = 6;
        scoreOne.width = 30;
        var tfTwo : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfTwo.align = TextFormatAlign.LEFT;
        scoreTwo = new TextField();
        scoreTwo.embedFonts = true;
        scoreTwo.defaultTextFormat = tfTwo;
        scoreTwo.selectable = false;
        scoreTwo.text = "0";
        scoreTwo.x = 90;
        scoreTwo.y = 6;
        scoreTwo.width = 30;
        // add children
        addChild(background);
        addChild(shadows);
        addChild(disk);
        addChild(playerOne);
        addChild(playerTwo);
        addChild(foreground);
        addChild(scoreOne);
        addChild(scoreTwo);
        // music
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
    
    public override function update() : Scene
    {
        super.update();
        if (true == focus) {
            if (breakTime > 0) {
                --breakTime;
            }
            disk.update();
            playerOne.update();
            playerTwo.update();
        }
        return this;
    }
    
    public function goal(num : Int) : Void
    {
        if (num == 1) {
            var score : Int = Std.parseInt(scoreOne.text) + 3;
            scoreOne.text = Std.string(score);
            if (score == 9) {
                round(1);
            } else {
                serve(2);
            }
        } else {
            var score : Int = Std.parseInt(scoreTwo.text) + 3;
            scoreTwo.text = Std.string(score);
            if (score == 9) {
                round(2);
            } else {
                serve(1);
            }
        }
    }
    
    private function serve(num : Int) : Void
    {
        breakTime = 120;
        playerOne.x = 10;
        playerOne.y = 73;
        playerTwo.x = 150;
        playerTwo.y = 73;
        disk.force.x = 0;
        disk.force.y = 0;
        if (num == 1) {
            disk.x = 20;
            disk.y = 73;
        } else {
            disk.x = 140;
            disk.y = 73;
        }
    }
    
    private function round(num : Int) : Void
    {
    }
    
    public override function draw() : Void
    {
        super.draw();
        if (true == focus) {
            disk.draw();
            playerOne.draw();
            playerTwo.draw();
        }
    }
    
    public override function clean() : Void
    {
        super.clean();
        disk.clean();
        playerOne.clean();
        playerTwo.clean();
        removeChild(background);
        removeChild(playerOne);
        removeChild(disk);
        removeChild(foreground);
    }
}