package components
{
	import fl.controls.Slider;

	public class SliderX extends Slider
	{
		private var _textArray:Array = new Array();
		public function SliderX(min:Number=0, max:Number=100, value:Number=10,
								snap:Number=.2, tick:Number=5)
		{
			super();
			this.minimum = min;
			this.maximum = max;
			this.value = value;
			this.snapInterval = snap;
			this.tickInterval = tick;
			this.width = 200;
		}
		
		public function numTicks():Number {	
			return Math.round((this.width / tickWidth()));
		}
		
		//below returns the space (in x) between ticks in a slider
		// if zero is included, add one, else don't
		public function tickWidth():Number {
			return (this.width / ((Math.abs(this.maximum - this.minimum))/this.tickInterval + 1));
		}
		
		public function get textArray():Array {
			return _textArray;
		}
		
		public function set textArray(value:Array):void {
			_textArray = value;
		}
		
	}
}