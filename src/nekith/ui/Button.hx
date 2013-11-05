package nekith.ui;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import nekith.Entity;

class Button extends Sprite implements Entity
{
    static var borderColor : UInt = 0x8C8C8C;
    static var backgroundColor : UInt = 0x6B6B6B;
    static var labelColor : UInt = 0xB2B2B2;
    static var helpColor : UInt = 0xB2B2B2;
    static var font : Font;
    
    public var rect(default, null) : Rectangle;
    private var label : TextField;
    private var help : TextField;
    
    public function new(rect : Rectangle, labelStr : String, ?helpStr : String = "")
    {
        super();
        this.rect = rect;
        x = rect.x;
        y = rect.y;
        // box
        var g : Graphics = graphics;
        g.beginFill(borderColor);
        g.drawRect(0, 0, rect.width, rect.height);
        g.beginFill(backgroundColor);
        g.drawRect(1, 1, rect.width - 2, rect.height - 2);
        g.endFill();
        // label
        var tf : TextFormat = new TextFormat(font.fontName, 14, labelColor);
        tf.align = TextFormatAlign.CENTER;
        label = new TextField();
        label.embedFonts = true;
        label.defaultTextFormat = tf;
        label.selectable = false;
        label.text = labelStr;
        label.y = 7;
        label.width = rect.width;
        addChild(label);
        // help
        var tfh : TextFormat = new TextFormat(f.fontName, 11, helpColor);
        tfh.align = TextFormatAlign.CENTER;
        help = new TextField();
        help.embedFonts = true;
        help.defaultTextFormat = tfh;
        help.selectable = false;
        help.text = helpStr;
        help.y = 35;
        help.width = rect.width;
        addChild(help);
    }
    
    public function clean() : Void
    {
        removeChild(label);
        removeChild(help);
    }
}