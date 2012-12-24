package objects
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import physics.*;
	
	public class Gun extends Sprite
	{
		protected var _frameRate:Number = 30;
		protected var _cooldown:Number = 0;
		protected var _cooldownTimer:Number = 7;
		protected var _accuracy:Number = 0;		// 0 = 100% accuracy, positive integers
		protected var _bulletVelocity:Number = 3; 		// bullet velocity multiple: 1 = standard3
		public var _gTimer:Timer;
		protected var _cooldown_on:Number = 1;
		
		public function Gun()
		{
			_gTimer = new Timer(_cooldownTimer * _frameRate);  // multiple by swf frame rate (default is 24)
			_gTimer.addEventListener(TimerEvent.TIMER, onGunTimer, false, 0, true);
			_gTimer.start();
		}
			
		// returns flags:
		// if returning 0, then cooldown is ENABLED, BUT the cooldown has not yet reached its timer
		// if returning -1, then cooldown is DISABLED
		// if returning 1, then cooldown is ENABLED, AND cooldown has reached its timer
		// if return 1, then gun is fire; if return 0, then gun is cooling down. if return -1, then cooldown is disabled (fire every frame)
		
		protected function checkCooldownStatus(cooldown_on:Number):Number {
			if (cooldown_on) {
				if (_cooldown >= _cooldownTimer)
					return 1;
				else 
					return 0;
			} 
			else
				return -1;
		}
		
		// this function returns angle of line between this(x,y) and refPoint(x,y)
		protected function findAngleToPoint(refPoint:Point):Number {
			var centerPoint:Point = new Point(this.width * 0.5, this.height * 0.5);
			
			var distY:Number = Point.distance(new Point(0, refPoint.y), new Point(0, centerPoint.y));
			if (refPoint.x <= 0 && refPoint.y <= 0) {
				trace('bafoon');
			}
			
			
			var distX:Number = Point.distance(new Point(refPoint.x, 0), new Point(centerPoint.x, 0));
			var theta:Number = Math.atan(distY/distX) * 0.318 * 180;   	// 0.318 ~= 1 / Math.PI, quicker this way
		
			trace('distX: ' + distX + ', distY: ' + distY);
	
			if (!(refPoint.x > centerPoint.x) && !(refPoint.y < centerPoint.y)) { 				// if refPoint is in III quadrant (relative to x,y of this)
				theta = - theta;
				trace('fart');
			}
			else if (refPoint.x > centerPoint.x && refPoint.y < centerPoint.y) {				// if refPoint is in I quad (relative to x,y of this)
				theta = -theta;
				theta += 180;
			}
			else if (!(refPoint.x < centerPoint.x) && !(refPoint.y < centerPoint.y)) { 			// if refPoint is in IV quad (relative to x,y of this)
				theta += 180;
			}
		
			return theta;
		}	
	
			
		protected function _fire(modFactor:Number = 0, cooldown_on:Number = 1):Boolean { 		// if bullet created, returns true. Else returns false.
			_cooldown_on = checkCooldownStatus(cooldown_on);
			if (_cooldown_on) {
	//			trace(_cooldown);
				var theta:Number = findAngleToPoint(new Point(this.mouseX, this.mouseY));
				trace("firing angle"+ theta)
				
				modFactor += _accuracy;
				//theta += Math.random()*modFactor - modFactor/2;
				trace(theta);
				var bullet:Bullet = new Bullet(theta);
			//	bullet.rotation = theta;
				bullet.x = this.x + this.width/2;
				bullet.y = this.y + this.height/2;
				this.parent.addChild(bullet);
				bullet.vx = _bulletVelocity * (-2*Math.cos(theta*Math.PI * .00556) + (Math.random()-.5)*.5);		// 0.00556 ~= 1 / 180, faster this way	
				bullet.vy = _bulletVelocity * (-2*Math.sin(theta*Math.PI * .00556) + (Math.random()-.5)*.5);
				if (_cooldown_on != -1) 		// if status = -1, then gun will fire EVERY SINGLE FRAME
					updateCooldown(false);
				return true;
			} 
			else {
				updateCooldown(true);
				return false;
			}
		}
		
		public function onGunTimer(e:TimerEvent):void {
			_cooldown = _cooldownTimer;
		}
		
		protected function updateCooldown(increase:Boolean):void {
			if(increase)
				_cooldown++;
			else 
				_cooldown = 0;		
		}
		
		public function fire(mod:Number = 0):Boolean {
			return this._fire(mod);
		}
		
		
		public function get accuracy():Number {
			return _accuracy;
		}
		
		public function set accuracy(num:Number):void {
			_accuracy = num;
		}
		
		
		public function get cooldown_on():Number {
			return _cooldown_on;
		}
		
		public function set cooldown_on(num:Number):void {
			_cooldown_on = num;
		}
	}
}