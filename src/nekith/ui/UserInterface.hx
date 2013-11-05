package nekith.ui;

import flash.Lib;
import flash.display.Sprite;
import flash.display.Shape;
import flash.ui.Mouse;
import flash.events.MouseEvent;

class UserInterface extends Sprite
{
    public var cursor(default, null) : Shape;
    
    public function new()
    {
        super();
        Mouse.hide();
        cursor = new Shape();
        addChild(cursor);
        var stage = Lib.current.stage;
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }
    
    public function onMouseMove(event : MouseEvent) : Void
    {
        cursor.x = event.stageX;
        cursor.y = event.stageY;
    }
}