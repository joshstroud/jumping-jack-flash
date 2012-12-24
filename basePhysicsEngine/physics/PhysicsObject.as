package physics
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import physics.collision.CollisionGroup;
	
	import utils.FrameRateTracker;

	dynamic public class PhysicsObject extends Sprite
	{
		// BOOLEAN SWITCHES
		protected var BOUNDS_ON:Boolean = true;
		protected var TOP_SPEED_ON:Boolean = true;
		protected var COLLISIONS_ON:Boolean = false;
		protected var STEP_RATE:int = 2;			// this variable controls the number of times physics objects are checked/updated PER SECOND
													// ***for collisions/CPU intensives ONLY*** So step rate of 4 means every 4 frames, update physics
													// (@30fps, then 15 checks every 2 seconds)		1 = every frame
		
		// PHYSICS VARIABLEs (ALL PROTECTED/ACCESSIBLE)
		protected var _globalCoor:Point;
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _ax:Number = 0;
		protected var _ay:Number = 0;
		//below are, for all purposes, 0, but because they are multiplied cannot be zero entirely
		protected var _friction:Number = .01; // percentage taken away; 1 = total stop, .1 = 10% loss, 0 = _frictionless
		protected var _gravity:Number = 0;
		protected var _collisionConst:Number = 0.9	// decides how elastic collisions are. basically, final velocity after collision is multiplied by this amount
		//protected var upperLeftBounds:Point;
		//protected var lowerRightBounds:Point;
		protected var _accelFactor:Number = 1;		// reduces acceleration, 1 = 100%a, .5 = 50%a, 0 = no acceleration
		protected var _bounce:Number = .85; // same as _friction, 1 = full bounce upon collision, .5 = 50% of orig velocity, 0 = stop
		protected var _bounds:Rectangle;
		protected var _topSpeed:Number = 10;
		protected var _paused:Boolean = false;
		protected var _reverseV:Number = 1; // if 1, normal velocity. if -1, then reversed velocity (i.e. press left arrow, goes right)
		protected var _distToNearestObject:Number = 0;
		protected var _mass:Number = 10;
		// !TODO! make the mass dependent on size(?)
		// !TODO! add acceleration and force, changing velocity according to equations a = v/t, and f = ma
		// !TODO! add listeners for when this is removed and added to the display list (Event.addedToStage, etc)
		
		// PRIVATE VARIABLES
		private var _currentStep:int = 1;				// This starts at 1
		private var lastCollided:Number = 0	; 			// use this in case an object gets stuck in a collision loop		(use as bool, 1=true)
		private var cols:Array;							// placeholder for optimization purposes					
		
		// READ-ONLY, STATIC VARIABLES (class, not object based)
		static protected var _physicsObjects:Array = [];
		static protected var _collisionChecker:CollisionGroup = new CollisionGroup();
		static protected var _eventLoop:Array = [];
		static protected var _frameRateTracker:FrameRateTracker = new FrameRateTracker();
		static private var firstRun:Boolean = true;												// if collision last physics cycle, then ignore current collision
	///	static protected var _collisionChecker:CollisionChecker = new CollisionChecker();
		
		
		
		public function PhysicsObject()
		{
			super();
			if(firstRun) {
				static_init();
			//	firstRun = false;		// firstRun will be set false when the eventLoop is started
			}
			else
				init();
		}
		
		private function static_init():void {			// this is called Only the FIRST TIME an physics object is created
			this.mouseEnabled = this.mouseChildren = false;		// faster
			if (COLLISIONS_ON) 	{
				_collisionChecker.addItem(this);
				_collisionChecker.returnAngle = true;
			}
			_physicsObjects = [this];
			_eventLoop = [this];
			this.addEventListener(Event.ADDED_TO_STAGE, startEventLoop, false, 0, true);
		}
		
		private function init():void {
			this.mouseEnabled = this.mouseChildren = false;		// faster
			if (COLLISIONS_ON) 	{
				_collisionChecker.addItem(this);
				_collisionChecker.returnAngle = true;
			}
			_physicsObjects[_physicsObjects.length] = this;
			_eventLoop[_eventLoop.length] = this;
			this.addEventListener(Event.ADDED_TO_STAGE, setBounds, false, 0, true);
		}
		
		private function startEventLoop(e:Event):void {
			e.target.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			firstRun = false;
			setBounds(new Event(Event.ADDED_TO_STAGE));
			trace('Started event loop');
		}
		
		private function setBounds(event:Event):void {
			this.parent.addChildAt(_frameRateTracker, 0);
			_bounds  = new Rectangle(parent.stage.x, parent.stage.y + 3, parent.stage.stageWidth, parent.stage.stageHeight);
			this.removeEventListener(Event.ADDED_TO_STAGE, setBounds);
		//	_globalCoor = this.localToGlobal(new Point(this.x, this.y));
			
	//		this.addEventListener(Event.ENTER_FRAME, onEnterFrame); // take all enterframes, put into one big function (instead of 50 diff events)
		//	this.addEventListener(Event.
		}
		
		private function onEnterFrame(e:Event):void {
			if(!paused) {
				_frameRateTracker.printFPS();
				for each( var obj:PhysicsObject in _eventLoop) {
					obj.updateVelocity(obj);
		
		/*			if(_currentStep < STEP_RATE) {
					obj._currentStep++;
						return;
					} else 
						_currentStep = 1;		
		*/
		
	//				findDistanceToNearestObject();
					if(COLLISIONS_ON)
						checkForCollisions();
					else
						NewCheckForCollisions();
					if(BOUNDS_ON )
						obj.checkBoundaries(obj);			// need to fix this
				}
			} else if (paused)
				return;
				//	removeEventListener(Event.ENTER_FRAME, onEnterFrame);}
		}
		
		protected function updateVelocity(target:PhysicsObject):void {
			_vx *= 1 - _friction;
			_vy *= 1 - _friction;
			_vy += _gravity;
			_vx += _ax * _accelFactor;
			_vy += _ay * _accelFactor;
			//two if statements below make sure velocity doesn't exceed _topSpeed of object
			if (TOP_SPEED_ON) {
				if (abs(_vx) > _topSpeed) {
					var signX:Number = 0;
					if (_vx < 0) 
					signX = -1;
					else if (_vx > 0) 
					signX = 1;
					_vx = _topSpeed*signX;
				}
				
				if (abs(_vy) > _topSpeed){
					var signY:Number = 0;
					if (_vy < 0) 
					signY = -1;
					else if (_vy > 0)
					signY = 1;
					_vy = _topSpeed*signY;
				}
			}
			x += _vx;
			y += _vy;
		//	applyMotionBlur(target);
			//rotation += 1 * Math.round(vy / 10);
			//if (!vy < .1) _vy = 0;
			//trace(name + ".y = " + y + " and vy = " + vy);
			_globalCoor = localToGlobal(new Point(x, y));
		}
		
		protected function applyMotionBlur(target:PhysicsObject):void {
			filters = [new BlurFilter(abs(vx*4), abs(vy*4), 1)];
			trace('blurX: ' + filters[0].blurX);
		}
		
		
		//*****	START COLLISION FUNCTIONS *****//
		
		protected function NewCheckForCollisions():void {
			return;
		}
		
		protected function checkForCollisions():void {			// this is called ONCE PER FRAME/STEP, not once per object (static, basically)
			// u is used to to denote final velocity (v') -> v1m1=u1m1
		
			cols = _collisionChecker.checkCollisions();		// array of collisions
			for(var i:uint = 0; i < cols.length; i++) {
				//trace('angle of collision:' +cols[i].angle);

				var obj1:PhysicsObject = cols[i].object1;
				var obj2:PhysicsObject = cols[i].object2;
				var m1:Number = obj1.mass;
				var m2:Number = obj2.mass;
				if(cols[i].overlapping.length > 100) {
					obj1.alpha = obj2.alpha = 0
					_collisionChecker.removeItem(obj1);
					_collisionChecker.removeItem(obj2);
				}
				// First calculate final velocity in X
				
				var ux1:Number = obj1.vx*(m1-m2)/(m1+m2) + obj2.vx*(2*m2)/(m1+m2)
				var ux2:Number = obj2.vx*(m2-m1)/(m1+m2) + obj1.vx*(2*m1)/(m1+m2)
				//trace('Final velocity of first particle in X is: '+ux1)
				//trace('Final velocity of second particle in X is: '+ux1)
				
				// Now calculate final velocity in y (same eqns)
				var uy1:Number = obj1.vy*(m1-m2)/(m1+m2) + obj2.vy*(2*m2)/(m1+m2)
				var uy2:Number = obj2.vy*(m2-m1)/(m1+m2) + obj1.vy*(2*m1)/(m1+m2)
				
				//trace('angle of impact: ' + cols[i].angle);
				var cVx:Number = obj1.vx + obj2.vx;
				var cVy:Number = obj1.vy + obj2.vy;
				
				obj1.vy = uy1;
				obj1.vx = ux1;
				obj2.vy = uy2;
				obj2.vx = ux2
				
				// below fast sin/cos calculations INLINE, not in function, for increased speed
				var x:Number = cols[i].angle;
				var sin:Number = 0;
				var cos:Number = 0;
				//always wrap input angle to -PI..PI
				if (x < -3.14159265)
				    x += 6.28318531;
				else
				if (x >  3.14159265)
				    x -= 6.28318531;
				
				//compute sine
				if (x < 0)
				    sin = 1.27323954 * x + .405284735 * x * x;
				else
				    sin = 1.27323954 * x - 0.405284735 * x * x;
				
				//compute cosine: sin(x + PI/2) = cos(x)
				x += 1.57079632;
				if (x >  3.14159265)
				    x -= 6.28318531;
				
				if (x < 0)
				    cos = 1.27323954 * x + 0.405284735 * x * x
				else
				    cos = 1.27323954 * x - 0.405284735 * x * x;
				// end sin/cos calculations
					
				//trace('objects collided!!!');				
			}
			// end for loop
			
			/* var bool:Boolean = (this._distToNearestObject <= this.width/2) || (this._distToNearestObject <= this.height / 2)
			if (this.parent && bool) {
				var collidingObj:PhysicsObject;
				var index:Number = _physicsObjects.indexOf(this);
				for (var j:int = 0; j < _physicsObjects.length; j++) {
					collidingObj = _physicsObjects[j];
				if (j != index && this.isColliding(collidingObj)) {
}						onCollision(collidingObj);
				}
			}*/
		}
	
		protected function findDistanceToNearestObject():void {
			return void; 		// not needed, use new collision API instead
		/*	
		var obj1:PhysicsObject = this;
			obj1._distToNearestObject = 99999;
			for( var j:int = 0; j < this.numOfObjects; j++) {
				var obj2:PhysicsObject = _physicsObjects[j]
                if (obj1 != obj2) {
	                var nDistX:Number = abs ( obj1.globalCoor.x - obj2.globalCoor.x );
	                var nDistY:Number = abs ( obj1.globalCoor.y - obj2.globalCoor.y );
	                var nDistance:Number = Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
					if(nDistance < this._distToNearestObject) 
						obj1._distToNearestObject = nDistance;
				//		ob
                }
			}
		*/
		}
	
	/*
		protected function onCollision(collidingObj:PhysicsObject):void {
			trace('before v: (' + this.vx + ', ' + this.vy + ')');
			if ( y > collidingObj.y) {
				if(_vy == 0) _vy = 2;
				_vy *= -_bounce;
				//rotation += _vy / _vx
			}
			else if ( y <= collidingObj.y) {
				_vy *= -_bounce;
			}
			
			if (x > collidingObj.x) {
				_vx *= -_bounce;
			}
			else if (x <= collidingObj.x) {
				_vx *= -_bounce;
			
			}
			trace('after v: (' + this.vx + ', ' + this.vy + ')');
		}

		public function getCollision(target2:DisplayObjectContainer,tollerance:Number=0):Rectangle {
			if (target2.parent == this.parent) 
		//	return _collisionChecker._getCollision(this, target2, tollerance);
			else {
				var oldParent:DisplayObjectContainer = target2.parent;
				if (oldParent == null)
					return null;
				var oldIndex:Number = oldParent.getChildIndex(target2);
				this.parent.addChild(target2);
		//		return _collisionChecker._getCollision(this, target2, tollerance);
				oldParent.addChildAt(target2, oldIndex);
			}
		}
		
		public function getCollisionPoint(target2:DisplayObject,tollerance:Number=0):Point {
			if (target2.parent == this.parent)
			//	return _collisionChecker._getCollisionPoint(this, target2, tollerance);
			else {
				var oldParent:DisplayObjectContainer = target2.parent;
				if (oldParent == null)
					return null;
				var oldIndex:Number = oldParent.getChildIndex(target2);
				this.parent.addChild(target2);
		//		return _collisionChecker._getCollisionPoint(this, target2, tollerance);
				oldParent.addChildAt(target2, oldIndex);
			}
		}
		
		public function isColliding(target2:DisplayObject, tollerance:Number=0):Boolean {
			if (target2.parent == this.parent)
			//	return _collisionChecker._isColliding(this, target2, tollerance);
			else {
				var oldParent:DisplayObjectContainer = target2.parent;
				if (oldParent == null)
					return false;
				var oldIndex:Number = oldParent.getChildIndex(target2);
				this.parent.addChild(target2);
			//	return _collisionChecker._isColliding(this, target2, tollerance);
				oldParent.addChildAt(target2, oldIndex);
			}
		}
		*/ //replaced by new collision API 
		//***** END COLLISION FUNCTIONS *****//
		
		
		
		protected function checkBoundaries(target:PhysicsObject):void {
			var col:Number = 0;
			if ( y >= _bounds.bottom) {
				if(!col)
					onCollisionWithBottomBounds();
					onBoundsCollision();
					return;
			}
			else if ( y <= _bounds.top) {
				if(!col)
					onCollisionWithTopBounds();
					onBoundsCollision();
					return;
			}
			else if (x >= _bounds.right) {
				if(!col)
					onCollisionWithRightBounds();
					onBoundsCollision();
					return;
			}
			else if (x <= _bounds.left) {
				if(!col)
					onCollisionWithLeftBounds();
					onBoundsCollision();
					return;
			}
			lastCollided = 0;
		}
		
		private function onBoundsCollision():void {
	//		if(!lastCollided)
	//			lastCollided++;
		}
		
		protected function onCollisionWithTopBounds():void {
			_vy *= -_bounce;
			_ay *= -_bounce;
			y = _bounds.top + 1;
			//this.destroy();
		}
	
		protected function onCollisionWithBottomBounds():void {
	//		if(_vy == 0) _vy = 2;
			_vy *= -_bounce;
			_ay *= -_bounce;
			y = _bounds.bottom - 1;
	//		rotation += _vy / _vx
		}
			
		protected function onCollisionWithLeftBounds():void {
			_vx *= -_bounce;
			_ax *= -_bounce;
			x = _bounds.left + 1;
		}
				
		protected function onCollisionWithRightBounds():void {
			_vx *= -_bounce;
			_ax *= -_bounce;
			x = _bounds.right - 1;
		}
		
		
		
		protected function destroy():void {
			if (this.parent)
				this.parent.removeChild(this);
			if(this.hasEventListener(Event.ENTER_FRAME)) 
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			delete(this);
			_physicsObjects.splice(_physicsObjects.indexOf(this), 1);
			
		}
		
		private function abs(n:Number):Number {			// optimized absolute function for speed
			if (n < 0)  n = -n;
			return n;
		}
		
		protected function wrapObjectPosition(target:PhysicsObject):void {
		}
		
		
		//***** START GETTERS SECTION *****//
		
		public function get vx():Number {
			return _vx;
		}
		
		public function get vy():Number {
			return _vy;
		}
		
		public function get ax():Number {
			return _ax;
		}
		
		public function get ay():Number {
			return _ay;
		}
		
		public function get friction():Number {
			return _friction;
		}
		
		public function get gravity():Number {
			return _gravity;
		}
		
		public function get bounds():Rectangle {
			return _bounds;
		}
		
		public function get bounce():Number {
			return _bounce;
		}

		public function get numOfObjects():Number {
			return _physicsObjects.length;
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
		
		public function get globalCoor():Point {
			return _globalCoor;
		}
		
		public function get mass():Number {
			return _mass;
		}
		//***** END GETTERS SECTION *****//
		
		
		
		//***** START SETTERS SECTION *****//
		
		public function set vx(value:Number):void {
			_vx = value;
		}
		
		public function set vy(value:Number):void {
			_vy = value;
		}
		
		public function set ax(value:Number):void {
			_ax = value;
		}
		
		public function set ay(value:Number):void {
			_ay = value;
		}
		
		public function set friction(value:Number):void {
			_friction = value;
		}
		
		public function set gravity(value:Number):void {
			_gravity = value;
		}
		
		public function set bounds(bounds:Rectangle):void {
			_bounds = bounds;
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
		
		public function set mass(value:Number):void {
			_mass = mass;
		}
		//***** END SETTERS SECTION *****//
		
		
	}
}