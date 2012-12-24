package physics.events
{
	import flash.events.Event;

	public class CollisionEvent extends Event
	{
		public function CollisionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
		}
		
	}
}