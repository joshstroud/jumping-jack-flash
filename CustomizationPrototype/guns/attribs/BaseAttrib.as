package guns.attribs
{
	import flash.display.Sprite;
	
	public class BaseAttrib extends Sprite	// this is display object so it can be a child of an object, and events it dispatched can bubble upwards to parents
	{													// this is NOT MEANT to be drawn on
		private var _type:String;
		private var _fullName:String = "none assigned";
		private var _value:Number;
		
		public static const ATTRIB_ARRAY:Array = [ATTRIB_PWR, ATTRIB_SPD, ATTRIB_ACC];
		public static const ATTRIB_PWR:String = "pwr";
		public static const ATTRIB_SPD:String = "spd";
		public static const ATTRIB_ACC:String = "acc";
		
		public function BaseAttrib(attribType:String, attribValue:Number)
		{
			this._type = attribType;
			this._value = attribValue;
		}

		public function get type():String {
			return _type;
		}
		
		public function get fullName():String {
			return _fullName;
		}

		public function get value():Number {
			return _value;	
		}
	
		public function set value(num:Number):void {
			_value = num;
			this.dispatchEvent(new AttribEvent(AttribEvent.ATTRIB_CHANGE_ABS, this._type, num));
		}

	}
	
}