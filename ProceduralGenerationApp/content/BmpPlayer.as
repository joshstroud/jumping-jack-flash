package content
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
public class BmpPlayer extends Sprite
	{
		//!TODO! Turn this into a generic function (enable oop)
		[Embed(source='phantomsprites.gif')]
		public var Player:Class;
		public function BmpPlayer()
		{
			//!TODO! if sprite goes off-screen, add a function to wrap it around to the other side
			var playerImg:Bitmap = new Player();
			this.addChild(playerImg);
		//	trace(playerImg.bitmapData.transparent);
		//	playerImg.blendMode = BlendMode.ADD;
			playerImg.scaleX = playerImg.scaleY = 0.1;
		//	trace(playerImg.bitmapData);
			var bmp:BitmapData = playerImg.bitmapData;
		//	trace( bmp.threshold(bmp, new Rectangle(0,0,playerImg.width,playerImg.height), new Point(0,0), '==', 0x00000000, 0x00000000, 0xff000000)); 
		}

	}
}