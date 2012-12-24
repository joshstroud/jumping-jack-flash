package guns.attribs
{
	import flash.display.Sprite;
	
	public class BaseAttrib extends Sprite	// this is display object so it can be a child of an object, and events it dispatched can bubble upwards to parents
	{													// this is NOT MEANT to be drawn on
		private var _subtype:String;		// subtype would be "gClassParticle" or "gSizeBalanced" etc
		private var _type:String;			// type would be "gSpec" or "gClass" or "gSize"
		private var _fullName:String = "none assigned";
		private var _value:Number;
		
		public function BaseAttrib(type:String, subtype:String, attribValue:Number)		// type will be given as one of the constants, ie "gSize"
		{	
			init(type, subtype, attribValue);						
		}

		private function init(type:String, subtype:String, attribValue:Number):void {
			this._type = type;															// subtype with be subtype constant, ie "gSizeLight"
			this._subtype = subtype;
			this._value = attribValue;
			this.dispatchEvent(new AttribEvent(AttribEvent.ATTRIB_CREATED));
		
		}

		public function create(type:String, subtype:String, attribValue:Number):void {		// this is the same as BaseAttrib, make any changes same
			init(type, subtype, attribValue);
		}
		
		public function get type():String {
			return _type;
		}
		
		public function get fullName():String {
			return _fullName;
		}
		
		public function get subtype():String {
			return _subtype;
		}

		public function get value():Number {
			return _value;	
		}
	
		public function set value(num:Number):void {
			_value = num;
			this.dispatchEvent(new AttribEvent(AttribEvent.ATTRIB_CHANGE_VALUE));
		}

	}
	
}