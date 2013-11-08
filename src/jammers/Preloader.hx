package jammers;

import flash.display.Shape;
import flash.display.Bitmap;
import flash.display.BitmapData;

@:bitmap("assets/gfx/loader/header.png") class BitmapLoaderHeader extends BitmapData { }
@:bitmap("assets/gfx/loader/bar.png") class BitmapLoaderBar extends BitmapData { }

class Preloader extends NMEPreloader
{
    private var loading : Shape;
    
    public function new()
    {
        super();
        removeChild(outline);
        removeChild(progress);
        var header : Bitmap = new Bitmap(new BitmapLoaderHeader(0, 0));
        header.x = 14;
        header.y = 2;
        addChild(header);
        var bar : Bitmap = new Bitmap(new BitmapLoaderBar(0, 0));
        bar.x = 11;
        bar.y = 126;
        addChild(bar);
        loading = new Shape();
        loading.x = 12;
        loading.y = 127;
        addChild(loading);
    }
    
    public override function onUpdate(bytesLoaded : Int, bytesTotal : Int)
    {
        loading.graphics.beginFill(0xE8F8E0);
        loading.graphics.drawRect(0, 0, bytesLoaded / bytesTotal * 142, 2);
    }
}