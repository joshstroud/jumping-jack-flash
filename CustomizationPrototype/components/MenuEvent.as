package components
{
	import flash.events.Event;

	public class MenuEvent extends Event
	{
		public static const ARROW_CLICKED:String = "arrowClicked";
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		
		private var _direction:String;
		
		public function MenuEvent(type:String, direction:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			_direction = direction;
			super(type, bubbles, cancelable);
		}
		
		public function get direction():String {
			return _direction
		}
		
	}
}