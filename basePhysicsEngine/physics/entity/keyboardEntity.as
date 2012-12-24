package physics.keyboardEntity
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import object.PhysicsObject;

	public class keyboardEntity extends PhysicsObject
	{

		public function keyboardEntity()
		{ 
			super();
			//setConstants("_accel", .8, "hello", .02, "_friction", .001);
		//	addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		
		//below is legacy code; currently handled in onEnterFrame in main class
		private function keyDownHandler(event:KeyboardEvent):void {
		  //  trace('Key Pressed: ' + event.keyCode);
		    switch (event.keyCode) {
		    case Keyboard.UP:
		        if(this._vy>0) _vy=0;
		        this._vy -= _accel;
		        break;
		    case Keyboard.DOWN:
		        if(this._vy<0) _vy=0;
		        this._vy += _accel;
		        break;
		    case Keyboard.LEFT:
		        if(this._vx>0) _vy=0;
		        this._vx -= _accel;
		        break;
		    case Keyboard.RIGHT:
		        if(this._vx<0) _vy=0;
		        this._vx += _accel;
		        break;
		    }
		    //trace('boobs');
		}
		
	// end function level
	}
}