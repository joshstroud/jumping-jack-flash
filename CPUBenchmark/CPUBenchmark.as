package {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	
	import objects.*;
	import objects.guns.*;
	
	import physics.CollisionChecker;

	public class CPUBenchmark extends Sprite
	{
		internal var mc:Bullet
		private var container:Sprite;
		public var allDObjs:Array;  // array of all VISIBLE display objects
		internal var col:CollisionChecker = new CollisionChecker();
		internal var gunn:Shotgun = new Shotgun();
		
		public function CPUBenchmark()
		{
			allDObjs = new Array(99);
			var size:Number = 55;
			container = new Sprite();  // container is the container for all objects created
			this.addChild(container);
			container.graphics.beginFill(0x888888);
			container.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight)
			container.graphics.endFill();
//			var rect:Sprite = new Sprite();
			container.addChild(gunn);
			allDObjs.push(gunn);
			gunn.x = stage.stageWidth/2 - size;
			gunn.y = stage.stageHeight/2 - size;
			gunn.graphics.beginFill(0xff0000);
			gunn.graphics.drawRect(0, 0, size, size)
			gunn.graphics.endFill(); 
	//		addEventListener(Event.ENTER_FRAME, fireBullets);
			trace(gunn.x, gunn.y);
			mc = new Bullet(45);
			container.addChild(mc);
			allDObjs.push(mc);
			mc.x = mc.y = 20000;
			container.addEventListener(MouseEvent.CLICK, onClick);  	// cool effect: change to mouseevent.mouse_over, run mouse over right of square
		//	container.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		private function fireBullets(e:Event):void {
			var dist:Number = Point.distance(new Point(mouseX, mouseY), new Point(mc.x, mc.y));
			
			var distY:Number = Point.distance(new Point(0, mouseY), new Point(0, mc.y));
			if(mouseY > mc.y) {
				dist *= -1;
			}
			
			var distX:Number = Point.distance(new Point(mouseX, 0), new Point(mc.x, 0));
	//		if(mouseX > mc.x) {
	//			dist *= -1;
	//		}
			
			var velocity:Point = mc.angleToVelocity(Math.atan2(distY, distX) * 180 / Math.PI, dist);
			mc.vy = velocity.y;
			mc.vx = velocity.x;
	//		mc.rotation =  
//			mc.angle = mc.rotation;
		//	trace(mc.rotation);
			
		}
		
		private function onClick(e:Event):void {
		for(var i:Number = 0; i < 100; i++) {
				gunn.fire();
				//gunn.
			}
		/*	if(!e.target.hasEventListener(MouseEvent.MOUSE_UP) ) {	
				container.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				container.addEventListener(MouseEvent.MOUSE_UP, onClick);
			}
			if(e.type == MouseEvent.MOUSE_UP) {
				container.removeEventListener(MouseEvent.MOUSE_UP, onClick);
				container.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				trace('framerate: ' + allDObjs.length);
			}
			*/
		}

		private function onEnterFrame(e:Event):void {
			for(var i:Number = 0; i < 100; i++) {
				gunn.fire();
				//gunn.
			}
		}
		
	}
}
