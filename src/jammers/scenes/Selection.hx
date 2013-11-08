package jammers.scenes;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Graphics;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.events.Event;
import flash.ui.Keyboard;
import flash.media.SoundChannel;
import nekith.Scene;
import jammers.Library;

class Selection extends Scene
{
    private var background : Bitmap;
    private var characterBoyPortrait : Bitmap;
    private var characterBoyName : TextField;
    private var characterGirlPortrait : Bitmap;
    private var characterGirlName : TextField;
    private var characterBigPortrait : Bitmap;
    private var characterBigName : TextField;
    private var cursorOne : Shape;
    private var cursorTwo : Shape;
    private var modesOne : TextField;
    private var modesTwo : TextField;
    private var cursorModeOne : Shape;
    private var cursorModeTwo : Shape;
    private var cdOne : Int;
    private var cdTwo : Int;
    private var okOne : Int;
    private var okTwo : Int;
    private var okModeOne : Int;
    private var okModeTwo : Int;
    private var channel : SoundChannel;
    
    public function new()
    {
        super();
        background = new Bitmap(Library.getInstance().menu);
        background.x = -3;
        addChild(background);
        // characterBoy
        characterBoyPortrait = new Bitmap(new BitmapData(16, 24, true));
        characterBoyPortrait.x = 25;
        characterBoyPortrait.y = 20;
        characterBoyPortrait.bitmapData.copyPixels(Library.getInstance().players, new Rectangle(0, 0, 16, 24), new Point(0, 0));
        addChild(characterBoyPortrait);
        var tfBoy : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfBoy.align = TextFormatAlign.CENTER;
        characterBoyName = new TextField();
        characterBoyName.embedFonts = true;
        characterBoyName.defaultTextFormat = tfBoy;
        characterBoyName.selectable = false;
        characterBoyName.text = "Al--";
        characterBoyName.x = 12;
        characterBoyName.y = 50;
        characterBoyName.width = 43;
        addChild(characterBoyName);
        // characterGirl
        characterGirlPortrait = new Bitmap(new BitmapData(16, 24, true));
        characterGirlPortrait.x = 71;
        characterGirlPortrait.y = 20;
        characterGirlPortrait.bitmapData.copyPixels(Library.getInstance().players, new Rectangle(32, 0, 16, 24), new Point(0, 0));
        addChild(characterGirlPortrait);
        var tfGirl : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfGirl.align = TextFormatAlign.CENTER;
        characterGirlName = new TextField();
        characterGirlName.embedFonts = true;
        characterGirlName.defaultTextFormat = tfGirl;
        characterGirlName.selectable = false;
        characterGirlName.text = "Yulia\nFast";
        characterGirlName.x = 58;
        characterGirlName.y = 50;
        characterGirlName.width = 43;
        addChild(characterGirlName);
        // characterBig
        characterBigPortrait = new Bitmap(new BitmapData(16, 24, true));
        characterBigPortrait.x = 117;
        characterBigPortrait.y = 20;
        characterBigPortrait.bitmapData.copyPixels(Library.getInstance().players, new Rectangle(64, 0, 16, 24), new Point(0, 0));
        addChild(characterBigPortrait);
        var tfBig : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfBig.align = TextFormatAlign.CENTER;
        characterBigName = new TextField();
        characterBigName.embedFonts = true;
        characterBigName.defaultTextFormat = tfBig;
        characterBigName.selectable = false;
        characterBigName.text = "Chuck\nStrong";
        characterBigName.x = 104;
        characterBigName.y = 50;
        characterBigName.width = 43;
        addChild(characterBigName);
        // cursors
        cursorOne = new Shape();
        cursorOne.x = 25;
        cursorOne.y = 10;
        var gOne : Graphics = cursorOne.graphics;
        gOne.clear();
        gOne.beginFill(0x183840);
        gOne.drawCircle(0, 0, 5);
        gOne.drawRect(-1, -1, 2, 2);
        addChild(cursorOne);
        cursorTwo = new Shape();
        cursorTwo.x = 40;
        cursorTwo.y = 10;
        var gTwo : Graphics = cursorTwo.graphics;
        gTwo.clear();
        gTwo.beginFill(0x183840);
        gTwo.drawCircle(0, 0, 5);
        gTwo.drawRect(-3, -1, 2, 2);
        gTwo.drawRect(1, -1, 2, 2);
        addChild(cursorTwo);
        // modes
        var tfModeOne : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfModeOne.align = TextFormatAlign.LEFT;
        modesOne = new TextField();
        modesOne.embedFonts = true;
        modesOne.defaultTextFormat = tfModeOne;
        modesOne.selectable = false;
        modesOne.text = "Player\nCPU";
        modesOne.x = 35;
        modesOne.y = 90;
        modesOne.width = 43;
        addChild(modesOne);
        var tfModeTwo : TextFormat = new TextFormat(Library.getInstance().font.fontName, 11, 0x183840);
        tfModeTwo.align = TextFormatAlign.LEFT;
        modesTwo = new TextField();
        modesTwo.embedFonts = true;
        modesTwo.defaultTextFormat = tfModeTwo;
        modesTwo.selectable = false;
        modesTwo.text = "Player\nCPU";
        modesTwo.x = 100;
        modesTwo.y = 90;
        modesTwo.width = 43;
        addChild(modesTwo);
        // mode cursors
        cursorModeOne = new Shape();
        cursorModeOne.x = 25;
        cursorModeOne.y = 96;
        var gModeOne : Graphics = cursorModeOne.graphics;
        gModeOne.clear();
        gModeOne.beginFill(0x183840);
        gModeOne.drawCircle(0, 0, 5);
        gModeOne.drawRect(-1, -1, 2, 2);
        addChild(cursorModeOne);
        cursorModeTwo = new Shape();
        cursorModeTwo.x = 90;
        cursorModeTwo.y = 96;
        var gModeTwo : Graphics = cursorModeTwo.graphics;
        gModeTwo.clear();
        gModeTwo.beginFill(0x183840);
        gModeTwo.drawCircle(0, 0, 5);
        gModeTwo.drawRect(-3, -1, 2, 2);
        gModeTwo.drawRect(1, -1, 2, 2);
        addChild(cursorModeTwo);
        // players
        okOne = 0;
        okTwo = 0;
        cdOne = 0;
        cdTwo = 0;
        // music
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
        // player one
        if (okOne == 0) {
            if (cdOne == 0) {
                if (true == keys[Keyboard.Q] || true == keys[Keyboard.A]) {
                    if (cursorOne.x > 25) {
                        cursorOne.x -= 45;
                        cdOne = 10;
                    }
                } else if (true == keys[Keyboard.D]) {
                    if (cursorOne.x < 115) {
                        cursorOne.x += 45;
                        cdOne = 10;
                    }
                }
                if (true == keys[Keyboard.Z] || true == keys[Keyboard.W]) {
                    if (cursorModeOne.y == 106) {
                        cursorModeOne.y = 96;
                    }
                } else if (true == keys[Keyboard.S]) {
                    if (cursorModeOne.y == 96) {
                        cursorModeOne.y = 106;
                    }
                }
            } else {
                --cdOne;
            }
            if (true == keys[Keyboard.T]) {
                okOne = 1 + Math.floor(cursorOne.x / 45);
                okModeOne = (cursorModeOne.y == 96 ? 1 : 2);
                Library.getInstance().soundThrow.play();
            }
        }
        // player two
        if (okTwo == 0) {
            if (cdTwo == 0) {
                if (true == keys[Keyboard.LEFT]) {
                    if (cursorTwo.x > 40) {
                        cursorTwo.x -= 45;
                        cdTwo = 10;
                    }
                } else if (true == keys[Keyboard.RIGHT]) {
                    if (cursorTwo.x < 130) {
                        cursorTwo.x += 45;
                        cdTwo = 10;
                    }
                }
                if (true == keys[Keyboard.UP]) {
                    if (cursorModeTwo.y == 106) {
                        cursorModeTwo.y = 96;
                    }
                } else if (true == keys[Keyboard.DOWN]) {
                    if (cursorModeTwo.y == 96) {
                        cursorModeTwo.y = 106;
                    }
                }
            } else {
                --cdTwo;
            }
            if (true == keys[Keyboard.O] || true == keys[Keyboard.NUMPAD_7]) {
                okTwo = 1 + Math.floor(cursorTwo.x / 45);
                okModeTwo = (cursorModeTwo.y == 96 ? 1 : 2);
                Library.getInstance().soundThrow.play();
            }
        }
        // launch
        if (okOne != 0 && okTwo != 0) {
            if (Std.random(2) == 0) {
                return new Playground(okOne, okTwo, okModeOne, okModeTwo);
            } else {
                return new ClassRoom(okOne, okTwo, okModeOne, okModeTwo);
            }
        }
        return this;
    }
    
    public override function draw() : Void
    {
        super.draw();
    }
    
    public override function clean() : Void
    {
        super.clean();
        removeChild(background);
        removeChild(characterBoyPortrait);
        removeChild(characterBoyName);
        removeChild(characterGirlPortrait);
        removeChild(characterGirlName);
        removeChild(characterBigPortrait);
        removeChild(characterBigName);
        removeChild(cursorOne);
        removeChild(cursorTwo);
        removeChild(modesOne);
        removeChild(modesTwo);
        removeChild(cursorModeOne);
        removeChild(cursorModeTwo);
        channel.stop();
        channel.removeEventListener(Event.SOUND_COMPLETE, music);
    }
}