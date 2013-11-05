package jammers;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import jammers.scenes.Playground;
import jammers.UserInterface;

class Main extends Sprite 
{
	private var inited : Bool;
	
	private function resize(e) 
	{
		if (inited == false) {
            init();
        } else {
            // (resize or orientation change)
        }
	}
	
	private function init() 
	{
		if (inited == false) {
            inited = true;
            var playground : Playground = new Playground();
            Lib.current.addChild(playground);
            playground.init();
            //Lib.current.addChild(new UserInterface());
            // Stage:
            // stage.stageWidth x stage.stageHeight @ stage.dpiScale
            
            // Assets:
            // nme.Assets.getBitmapData("img/assetname.jpg");
        }
	}

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.EXACT_FIT;
		Lib.current.addChild(new Main());
	}
}
