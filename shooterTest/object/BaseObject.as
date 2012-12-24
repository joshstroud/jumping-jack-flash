package object
{
	import flash.display.MovieClip;
	import flash.events.Event;

	dynamic public class BaseObject extends MovieClip
	{
		protected const BOUNDS_ON:Boolean = false;
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _accel:Number = 1.2;
		//below are, for all purposes, 0, but because they are multiplied cannot be zero entirely
		protected var _friction:Number = 0; 		// percentage taken away; 1 = total stop, .1 = 10% loss, 0 = _frictionless
		protected var _gravity:Number = 0;
		//protected var upperLeftBounds:Point;
		//protected var lowerRightBounds:Point;
		protected var _accelFactor:Number = 0;
		protected var _bounce:Number = .85; 		// same as _friction, 1 = full bounce upon collision, .5 = 50% of orig velocity, 0 = stop
		protected var _bounds:Object;
		protected var _topSpeed:Number = -1;
		protected var _paused:Boolean = false;
		protected var _reverseV:Number = 1; 		// if 1, normal velocity. if -1, then reversed velocity (i.e. press left arrow, goes right)
		protected var _wrap:Array = [true, true]; 	// Determines whether object wraps around screen (if true, then wraps around screen)
													// Goes in order of [x-axis, y-axis]
													
		// !TODO! add a mass variable, for inertia, collisions, etc.
		// !TODO! make the mass dependent on size(?)
		
		//below are read-only, static (class, not object based) vars
		static protected var _numOfObjects:Number = 0;
		static protected var _onEnterFrameArray:Array = new Array();
		
		public function BaseObject()
		{
			super();
			_numOfObjects++;
			this.addEventListener(Event.ADDED_TO_STAGE, setBounds);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function setBounds(event:Event):void {
			_bounds = {up:parent.stage.x + 3, left:parent.stage.y, right:parent.stage.stageWidth - 7, down:parent.stage.stageHeight - 10};
			//upperLeftBounds = new Point(stage.x + 3, stage.y);
		//	lowerRightBounds = new Point(stage.stageWidth - 7, stage.stageHeight - 10);
		}
		
		protected function onEnterFrame(event:Event):void {
			if(!paused) {
				updateVelocity(this);
				wrapObject(this);
			if(BOUNDS_ON) checkBoundaries(this);
			} else if (paused) {
			//	removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		protected function updateVelocity(target:BaseObject):void {
			//trace('finish updateVelocity function in object.BaseObject')
				
				target.vx *= 1 - target.friction;
				target.vy *= 1 - target.friction;
				target.vy += target.gravity;
				
				target = checkTopSpeed(target);
				target.x += target.vx;
				target.y += target.vy;
				//target.rotation += 1 * Math.round(target.vy / 10);
			//if (!target.vy < .1) target._vy = 0;
			//trace(target.name + ".y = " + target.y + " and vy = " + target.vy);
		}
		
		//currently, not needed, better just to use given getters/setters and/or a dynamic class
		//Below, given variable to change, followed by value, assigns value to variable
		// e.g. setConstants("_accel", 6, "Friction", 2, "Power", "Hello", etc. to infinity);
	/*	public function setConstants(... args):void {
			// class constants must be declared/created in baseObject class (this)
			for(var i:Number = 0; i <= Math.floor(args.length / 2); i += 2) {
				try {
					this[String(args[i])] = args[i+1];
					trace('Setting constant ' + args[i] + " of " + this + " to value " + args[i+1]);
				} catch (error:Error) {
					trace(error.message + "\nWhen trying to set possibly non-existent constant " + args[i] + " to value " + args[i+1]);
				}
			}
		} */
		
		private function checkTopSpeed(target:BaseObject):BaseObject {
			// if topSpeed < 0, then target has no NO TOP SPEED (i.e. topSpeed = infinity)
			// if topSpeed = 0, then target has NO MOVEMENT
			// if topSpeed > 0, then NORMAL CHECK FOR TOP SPEED
			
			if (topSpeed < 0) return target; 
			if (Math.abs(target.vx) > target.topSpeed) {
				var signX:Number = 0;
				if (target.vx < 0) 
				signX = -1;
				else if (target.x > 0) 
				signX = 1;
				target.vx = target.topSpeed*signX;
			}
			
			if (Math.abs(target.vy) > target.topSpeed){
				var signY:Number = 0;
				if (target.vy < 0) 
				signY = -1;
				else if (target.vy > 0)
				signY = 1;
				target.vy = target.topSpeed*signY;
			}
			return target;
		}
		
		protected function checkBoundaries(target:Object):void {
			//if ( target.y >= _bounds.down || target.y <= _bounds.up) {
			var margin:Number = 1;
			
			if ( target.y >= _bounds.down) {
				if(target._vy == 0) target._vy = 2;
				target._vy *= -_bounce;
				target.y = _bounds.down - margin;
				//target.rotation += target._vy / target._vx
			}
			else if ( target.y <= _bounds.up) {
				target._vy *= -_bounce;
				target.y = _bounds.up + margin;
			}
			else if (target.x >= _bounds.right) {
				target._vx *= -_bounce;
				target.x = _bounds.right - margin;
			}
			else if (target.x <= _bounds.left) {
				target._vx *= -_bounce;
				target.x = _bounds.left + margin;
			
			}
		}
		
		private function wrapObject(target:Object):void {
			var startX:Number, startY:Number = 0;
			if (target.wrap[0]) {
				var width:Number = this.root.stage.stageWidth;
				if (target.x > width) target.x -= startX;
				else if (target.x < startX) target.x += width;
			}
			
			if (target.wrap[1]) {
				var height:Number = this.root.stage.stageHeight;
				if (target.y > height) target.y -= startY;
				else if (target.y < startY) target.y += height;
			}
		}
		
		// below getters 
		public function get vx():Number {
			return _vx;
		}
		
		public function get vy():Number {
			return _vy;
		}
		
		public function get accel():Number {
			return _accel;
		}
		
		public function get friction():Number {
			return _friction;
		}
		
		public function get gravity():Number {
			return _gravity;
		}
		
		public function get bounds():Object {
			return _bounds;
		}
		
		public function get bounce():Number {
			return _bounce;
		}

		public function get numOfObjects():Number {
			return _numOfObjects;
		}
		public function get topSpeed():Number {
			return _topSpeed;
		}
		
		public function get accelFactor():Number {
			return _accelFactor;
		}
		
		public function get paused():Boolean {
			return _paused;
		}
		
		public function get reverseV():Number {
			return _reverseV;
		}
		
		public function get wrap():Array {
			return _wrap;
		}
		
		// setters for variables
		public function set vx(value:Number):void {
			_vx = value;
		}
		
		public function set vy(value:Number):void {
			_vy = value;
		}
		
		public function set accel(value:Number):void {
			_accel = value;
		}
		
		public function set friction(value:Number):void {
			_friction = value;
		}
		
		public function set gravity(value:Number):void {
			_gravity = value;
		}
		
		public function set bounds(bounds:Object):void {
			if(!bounds.hasOwnProperty("left")) {
				bounds.left = _bounds.left;
			}
			if (!bounds.hasOwnProperty("right")){
				bounds.right = _bounds.right;
			}
			if (!bounds.hasOwnProperty("up")){
				bounds.up = _bounds.up;
			}
			if( !bounds.hasOwnProperty("down")){
				bounds.up = _bounds.up;
			}

			_bounds.left = bounds.left;
			_bounds.up = bounds.up;
			_bounds.right = bounds.right;
			_bounds.down = bounds.down;
		}
		
		public function set bounce(value:Number):void {
			_bounce = value;
		}
		
		public function set topSpeed(value:Number):void {
			_topSpeed = value;
		}
		
		public function set paused(value:Boolean):void {
			_paused = value;
		}
		
		public function set accelFactor(value:Number):void {
			_accelFactor = value;
		}
		
		public function set reverseV(value:Number):void {
			_reverseV = value;
		}
		
		public function set wrap(ar:Array):void {
			_wrap[0] = ar[0];
			_wrap[1] = ar[1];
		}
		
	}
}