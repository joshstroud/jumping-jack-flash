package object.tile
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import object.PhysicsObject;
	
public class Tile extends PhysicsObject 
	{
		

		//!TODO! Turn this into a generic function (enable oop)
		[Embed(source='grass_texture.jpg')]
		public var Player:Class;
		private static var TILE_ACCEL:Number = 100;
		public function Tile()
		{
			super();
			_accel = TILE_ACCEL;
			
		//!TODO! friction screws up tile alignment... WHY?	
			_friction = 0.05;
			_gravity = 0;
			_accelFactor = 1;
			_reverseV = -1;
		
			//!TODO! if sprite goes off-screen, add a function to wrap it around to the other side
			var playerImg:Bitmap = new Player();
			this.addChild(playerImg);
		//	trace(playerImg.bitmapData.transparent);
		//	playerImg.blendMode = BlendMode.ADD;
			playerImg.scaleX = playerImg.scaleY = 0.3;
		//	trace(playerImg.bitmapData);
			var bmp:BitmapData = playerImg.bitmapData;
		//	trace( bmp.threshold(bmp, new Rectangle(0,0,playerImg.width,playerImg.height), new Point(0,0), '==', 0x00000000, 0x00000000, 0xff000000)); 
		}
		
	/*	public function updatePosition(vx:Number, vy:Number):void {
			for (var i:Number = 0; i < TILE_ACCEL; i++) {
				this.x -= vx / TILE_ACCEL;
			}
			for (var j:Number = 0;j < TILE_ACCEL ; j++) {
				this.y -= vy / TILE_ACCEL;
			}
		//	trace(this.x + ", " + this.y);
		} */ 		
	//NOT NEEDED. replaced byu updateVelocity() in baseObject class
	
	}
}