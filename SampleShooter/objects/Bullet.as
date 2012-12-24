package objects
{
	import flash.events.*;
	import flash.media.*;
	
	import physics.PhysicsObject;
	
	public class Bullet extends PhysicsObject
	{
		//[Embed(source="media/pistol 38 cal x1.mp3")]
		//private var shotSnd1:Class;
		
	//	[Embed(source="media/pistol 38 cal x2.mp3")]
		private var shotSnd2:Class;
		
	//	[Embed(source="media/pistol 38 cal x3.mp3")]
		private var shotSnd3:Class;
		
		private var soundArray:Array = [/*shotSnd1, */shotSnd2, shotSnd3];
		
		private var _angle:Number;
		private var sizeFactor:Number = 3;
		private var size:Number = 0;
		
		public function Bullet(bAngle:Number)
		{
			bounce = 1;
			BOUNDS_ON = true;
			super();
			friction = 0;	
			_angle = bAngle;
			var generalBulletSize:Number = 10;
			size = generalBulletSize+(Math.random()*sizeFactor-.25*sizeFactor)
			
			graphics.beginFill(Math.random()*0xFFFFFF);
			graphics.drawCircle(0, 0, size);
			this.mass = size;
			//graphics.drawEllipse(0, 0, bulletSize*1.5, bulletSize);
			graphics.endFill();
		//	this.rotation = _angle;
		//	playShotSound();
		//	trace('num bullets: ' + this.numOfObjects);
		}

		public function get Angle():Number {
			return _angle;
		}
	
		override protected function updateVelocity(target:PhysicsObject):void {
	//		trace('framerate: ' + this.root.fps);
			if (target.stage != null) {
		//		if (target.x > target.stage.stageWidth + target.width || target.x < 0 - target.width)
			//		target.destroy();
		//		else if ((target.y > target.stage.stageHeight + target.height) || (target.y < 0 - target.height) )
			//	target.destroy(); 
			}
			super.updateVelocity(target);
		}
	
	/*	public function angleToVelocity(angle:Number, dist:Number):Point {  // give the angle IN DEGREES // dist is distance from current position to new coordinate
	//		var velocity:Point = new Point();
			velocity.x = Math.sin(angle/180*Math.PI) * dist;
			velocity.y = Math.cos(angle/180*Math.PI) * dist;
			trace('vx: ' + velocity.x + ', vy: ' +velocity.y);
			return velocity;
		}
	*/
	
	/*	override protected function onCollision(collidingObj:PhysicsObject):void {
		//	this.destroy();
		//	collidingObj.destroy();
			trace('objects destroyed!');
		}
	*/
	
		private function playShotSound():void {
		//	var shot1:Sound = new shotSnd1 as Sound;
		//	soundArray.push(shot1);
		//	soundArray.shift();
			var shot2:Sound = new shotSnd2 as Sound;
			soundArray[soundArray.length] = shot2;
			soundArray.shift();
			var shot3:Sound = new shotSnd3 as Sound;
			soundArray[soundArray.length] = shot3;
			soundArray.shift();
			soundArray[ int(Math.random()*2)].play()
		}
		
	}
}