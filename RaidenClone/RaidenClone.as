package {
	import flash.display.MovieClip;
	import flash.events.*;
	[SWF(backgroundColor="0x666666",width="400",height="640",frameRate="50")]
	public class RaidenClone extends MovieClip {
		
		public function RaidenClone() {
			var ship:Ship = new Ship(32, 32);
			addChild(ship);
			ship.x = ship.y = 20;
			ship.addEventListener(Event.ENTER_FRAME, moveShip);
			stage.focus = ship;
			ship.addEventListener(KeyboardEvent.KEY_DOWN, movePlayerShip);
			ship.addEventListener(KeyboardEvent.KEY_UP, stopPlayerShip);
		}
	
		private function moveShip(e:Event):void {
			e.target.x++;
			e.target.y++;
		}
	
		private function movePlayerShip(e:KeyboardEvent):void {
			if(e.keyCode == 37) e.target.x -= 2;//keyCode: lt, up, rt, down -> 37, 38, 39 ,40
		
		}
	
		private function stopPlayerShip(e:KeyboardEvent):void {
			trace('hell');
			e.currentTarget.removeEventListener(Event.ENTER_FRAME, moveShip);
		}
	
	}
}
