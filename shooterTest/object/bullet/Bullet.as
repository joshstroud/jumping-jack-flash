package object.bullet
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	import object.BaseObject;

	public class Bullet extends BaseObject
	{
		
		public function Bullet()
		{
			super();
			var motionBlur:BlurFilter = new BlurFilter();
			motionBlur.blurX = vx;
			this.graphics.beginFill(0xffff00, 1);
			
			this.graphics.drawRect(0, 0, 1, 0);
			this.graphics.drawRect(0, 1, 3, 1);
			this.graphics.drawRect(0, 2, 5, 2);
			this.graphics.endFill();
			this.filters = [motionBlur];
			this.vx = 22;
			this.wrap = [true, true];

		}
		
		override protected function onEnterFrame(event:Event):void {
			super.onEnterFrame(event);
			this.filters[0].blurX = vx;
			vx+= .1;
		}
		
	}
}