package {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	
	import objects.*;
	import objects.effects.*;
	import objects.guns.*;
	
	import physics.PhysicsObject;
	import physics.collision.*;
	
	public class SampleShooter extends Sprite
	{
		private var container:Sprite;
		public var allDObjs:Array;  // array of all VISIBLE display objects
		internal var gunn:Gun = new Gun();
		private var fps:Number = 30;
		//private var numObjs_text:TextField = new TextField();
		
		private static var physicsObject:PhysicsObject = new PhysicsObject();
		
		public function SampleShooter()
		{
			stage.frameRate = 30;
			allDObjs = [99];
			var size:Number = 55;
			container = new Sprite();  // container is the container for all objects created
			var fog:Fog = new Fog();
			container.addChild(fog);
			
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
	//		trace(gunn.x, gunn.y);
			
			//container.addChild(numObjs_text);
			//numObjs_text.x = stage.stageWidth - 28;
	
			container.addEventListener(MouseEvent.MOUSE_DOWN, onClick, false, 0, true);  	// cool effect: change to mouseevent.mouse_over, run mouse over right of square
		//	container.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		
		private function findNumObjects():Number {
			return physicsObject.numOfObjects;
		}
		
		private function onClick(e:Event):void {
			if(!e.target.hasEventListener(MouseEvent.MOUSE_UP) ) {	
				container.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
				container.addEventListener(MouseEvent.MOUSE_UP, onClick), false, 0, true;
			}
			if(e.type == MouseEvent.MOUSE_UP) {
				container.removeEventListener(MouseEvent.MOUSE_UP, onClick);
				container.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}

		private function onEnterFrame(e:Event):void {
			gunn.fire();
			gunn._gTimer.reset();
			gunn._gTimer.start();
		}
		
		
	}
}
