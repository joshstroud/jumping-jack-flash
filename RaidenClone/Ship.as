package {
	import flash.display.MovieClip;

	public class Ship extends MovieClip
	{
		public function Ship(_width:Number = 10, _height:Number = 10)
		{
			this.graphics.beginFill(0);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
			
		}
	}
}
