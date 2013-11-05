package jammers;

import flash.Lib;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;
import flash.ui.Mouse;
import flash.events.MouseEvent;

class UserInterface extends nekith.ui.UserInterface
{
    static private var instance : UserInterface = null;
    
    static public function getInstance() : UserInterface
    {
        if (instance == null) {
            instance = new UserInterface();
        }
        return instance;
    }
    
    private function new()
    {
        super();
        var g : Graphics = cursor.graphics;
        g.clear();
        g.beginFill(0x183840);
        g.drawRect(0, 0, 2, 6);
        g.beginFill(0x183840);
        g.drawRect(0, 0, 6, 2);
    }
}