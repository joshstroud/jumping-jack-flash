package objects.effects
{
	import flash.display.*;
	import flash.events.Event;
	
	public class Fog extends Sprite
	{
		public function Fog()
		{
			this.graphics.beginFill(0x00ff00, 0);
			this.graphics.drawCircle(-1000, -1000, 1);
			this.graphics.endFill();
			this.addEventListener(Event.ADDED_TO_STAGE, initialize, false, 0, true)
		}

		private function initialize(e:Event):Bitmap {
			var bitmap:BitmapData = new BitmapData(this.parent.stage.stageWidth, this.parent.stage.stageHeight, false, 0xff000000);
			bitmap.perlinNoise(200, 100, 5, 1000, false, true, 1, true, null);
			var fog:Bitmap = new Bitmap(bitmap);
			return fog;
		}

	}
}