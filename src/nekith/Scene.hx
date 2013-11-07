package nekith;

import haxe.Timer;
import flash.Lib;
import flash.geom.Point;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import jammers.UserInterface;

class Scene extends Sprite
{
    public var dimension(default, null) : Point;
    public var mouse(default, null) : Point;
    public var click(default, null) : Bool;
    public var keys(default, null) : Array<Bool>;
    public var focus(default, null) : Bool;
    private var currentTime : Float = 0;
    private var accumulator : Float = 0;
    
    private function new()
    {
        super();
        dimension = new Point(1000, 600);
        mouse = new Point(0, 0);
        click = false;
        keys = [];
    }
    
    public function init() : Void
    {
		var stage = Lib.current.stage;
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        stage.addEventListener(Event.ENTER_FRAME, onEnter);
        stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        stage.addEventListener(Event.ACTIVATE, onActivate);
        currentTime = Timer.stamp();
        focus = true;
    }
    
    public function onKeyDown(event : KeyboardEvent) : Void
    {
        if (false == keys[event.keyCode]) {
            keys[event.keyCode] = true;
        }
    }
    
    public function onKeyUp(event : KeyboardEvent) : Void
    {
        keys[event.keyCode] = false;
    }
    
    public function onMouseMove(event : MouseEvent) : Void
    {
        mouse.x = event.stageX;
        mouse.y = event.stageY;
    }
    
    public function onMouseDown(event : MouseEvent) : Void
    {
        click = true;
    }
    
    public function onMouseUp(event : MouseEvent) : Void
    {
        click = false;
    }
    
    public function onEnter(event : Event) : Void
    {
        var newTime : Float = Timer.stamp();
        var frameTime : Float = newTime - currentTime;
        currentTime = newTime;
        accumulator += frameTime;
        while (1 / 30.0 <= accumulator) {
            var scene : Scene = update();
            if (scene != this) {
                this.clean();
                Lib.current.addChildAt(scene, 0);
                scene.init();
                return;
            }
            accumulator -= 1 / 60.0;
        }
        draw();
    }
    
    public function onDeactivate(event : Event) : Void
    {
        focus = false;
    }
    
    public function onActivate(event : Event) : Void
    {
        focus = true;
    }
    
    public function update() : Scene
    {
        return this;
    }
    
    public function draw() : Void
    {
    }
    
    public function clean() : Void
    {
        var stage = Lib.current.stage;
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        stage.removeEventListener(Event.ENTER_FRAME, onEnter);
        stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
        stage.removeEventListener(Event.ACTIVATE, onActivate);
        Lib.current.removeChild(this);
    }
}