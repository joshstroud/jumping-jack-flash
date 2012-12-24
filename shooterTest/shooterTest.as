package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import object.bullet.*;

	public class shooterTest extends Sprite
	{
		public function shooterTest()
		{
			var root:MovieClip = new MovieClip;
			root.width = stage.stageWidth;
			root.height = stage.stageHeight;
			root.x = root.y = 0;
			
			root.addEventListener(MouseEvent.CLICK, clickEvent);
		}
	
		private function clickEvent(e:MouseEvent):void {
			trace('but');
			var bullet:Bullet = new Bullet;
			bullet.x = bullet.y = 200;
			addChild(bullet);
			
		}
		
	}
}
