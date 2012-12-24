package content
{
	import flash.display.Bitmap;
	public class ShipSprite extends BmpPlayer
	{
		var test:String = 'phantomsprites.gif';
		public var Player:Class;
		//!TODO! Turn this into a generic function (enable oop)
		[Embed(source=test)]
		public function BmpPlayer()
		{ super();
			var playerImg:Bitmap = new Player();
			this.addChild(playerImg);
			playerImg.scaleX = playerImg.scaleY = 0.1;
		}

	}
}