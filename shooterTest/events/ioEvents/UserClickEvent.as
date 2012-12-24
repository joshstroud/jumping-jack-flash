package events.ioEvents
{
	import flash.events.MouseEvent;
	
	public class UserClickEvent extends MouseEvent
	{
		public static var fire:String = "fire";
		
		public function UserClickEvent() {
			super(type);
		}
	}
}