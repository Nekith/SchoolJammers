package jammers.scenes;

import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.media.SoundChannel;
import flash.events.Event;
import nekith.Scene;
import jammers.Library;
import jammers.entities.Disk;
import jammers.entities.Player;
import jammers.entities.Cpu;

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
    private var roundsOne : Int;
    private var roundsTwo : Int;
    private var rounds : Shape;
    private var shaking : Int;
    private var ended : Int;
    private var channel : SoundChannel;
    
    private function new(diskBitmap : BitmapData, charOne : Int, charTwo : Int, modeOne : Int, modeTwo : Int)
    {
        super();
        dimension = new Point(180, 144);
        shadows = new Sprite();
        breakTime = 0;
        shaking = 0;
        ended = -1;
        // disk
        disk = new Disk(this, diskBitmap);
        disk.x = 120;
        disk.y = 60;
        // playerOne
        if (modeOne == 1) {
            playerOne = new Player(this, 1, charOne);
        } else {
            playerOne = new Cpu(this, 1, charOne);
        }
        playerOne.x = 10;
        playerOne.y = 73;
        // playerTwo
        if (modeTwo == 1) {
            playerTwo = new Player(this, 2, charTwo);
        } else {
            playerTwo = new Cpu(this, 2, charTwo);
        }
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
        // scoreTwo
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
        // rounds
        roundsOne = 0;
        roundsTwo = 0;
        rounds = new Shape();
        // add children
        addChild(background);
        addChild(shadows);
        addChild(disk);
        addChild(playerOne);
        addChild(playerTwo);
        addChild(foreground);
        addChild(scoreOne);
        addChild(scoreTwo);
        addChild(rounds);
        // music
        music();
    }
    
    public function music(?event : Event) : Void
    {
        if (channel != null) {
            channel.stop();
        }
        channel = Library.getInstance().musicGame.play();
        channel.soundTransform.volume = 1;
        channel.addEventListener(Event.SOUND_COMPLETE, music);
    }
    
    public override function update() : Scene
    {
        super.update();
        if (focus == true) {
            if (ended == -1) {
                if (breakTime > 0) {
                    --breakTime;
                }
                disk.update();
                playerOne.update();
                playerTwo.update();
            } else {
                --ended;
                if (ended == 0) {
                    return new MainMenu();
                }
            }
        }
        return this;
    }
    
    public function goal(num : Int, add : Int) : Void
    {
        playerOne.stop();
        playerTwo.stop();
        if (add == 3) {
            Library.getInstance().soundGoal.play();
            shaking = 4;
            if (num == 1) {
                x = 10;
            } else {
                x = -10;
            }
        }
        if (num == 1) {
            var score : Int = Std.parseInt(scoreOne.text) + add;
            scoreOne.text = Std.string(score);
            if (score >= 11) {
                round(1);
            } else {
                serve(2);
            }
        } else {
            var score : Int = Std.parseInt(scoreTwo.text) + add;
            scoreTwo.text = Std.string(score);
            if (score >= 11) {
                round(2);
            } else {
                serve(1);
            }
        }
    }
    
    private function serve(num : Int) : Void
    {
        breakTime = 90;
        playerOne.x = 10;
        playerOne.y = 73;
        playerTwo.x = 150;
        playerTwo.y = 73;
        disk.stop();
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
        scoreOne.text = "0";
        scoreTwo.text = "0";
        if (num == 1) {
            ++roundsOne;
            var g : Graphics = rounds.graphics;
            for (i in 0...roundsOne) {
                g.beginFill(0x183840);
                g.drawRect(70 - i * 3, 2, 2, 2);
            }
            if (roundsOne == 2) {
                disk.stop();
                ended = 120;
            } else {
                serve(2);
            }
        } else {
            ++roundsTwo;
            var g : Graphics = rounds.graphics;
            for (i in 0...roundsTwo) {
                g.beginFill(0x183840);
                g.drawRect(90 + i * 3, 2, 2, 2);
            }
            if (roundsTwo == 2) {
                disk.stop();
                ended = 120;
            } else {
                serve(1);
            }
        }
    }
    
    public override function draw() : Void
    {
        super.draw();
        if (true == focus) {
            if (x > 0) {
                if (shaking == 0) {
                    x = 1 - x;
                    shaking = 4;
                } else {
                    --shaking;
                }
            } else if (x < 0) {
                if (shaking == 0) {
                    x = -1 - x;
                    shaking = 4;
                } else {
                    --shaking;
                }
            }
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
        channel.stop();
        channel.removeEventListener(Event.SOUND_COMPLETE, music);
    }
}