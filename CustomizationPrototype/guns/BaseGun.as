package guns
{
	import flash.display.Sprite;
	
	import guns.attribs.*;
	
	public class BaseGun extends Sprite
	{
		public var gun_attribs:Array;

		private var attrib_pwr:BaseAttrib = new BaseAttrib(BaseAttrib.ATTRIB_PWR, 1);
		private var attrib_spd:BaseAttrib = new BaseAttrib(BaseAttrib.ATTRIB_SPD, 1);
		private var attrib_acc:BaseAttrib = new BaseAttrib(BaseAttrib.ATTRIB_ACC, 1);

		public function BaseGun()
		{
			this.addEventListener(AttribEvent.ATTRIB_CHANGE_ABS, onAttribChange);
		}

		public function onAttribChange(e:AttribEvent):void {
			var attrib:BaseAttrib = e.target as BaseAttrib;
			var color = 0x000000
			var offset:Number = 0
			if (e.attrib == BaseAttrib.ATTRIB_ACC) { 
				color = 0xff0000
				offset = 80;
			} else if (e.attrib == BaseAttrib.ATTRIB_PWR) 
				color = 0x00ff00
			else if (e.attrib == BaseAttrib.ATTRIB_SPD) {
				color = 0x0000ff
				offset = 40;
			}
			
			trace('attribute of type ' + e.attrib + ' and value ' + e.value);
			attrib.graphics.clear();
			attrib.graphics.beginFill(color)
			attrib.graphics.drawRect(offset,0,10*e.value,10*e.value)
			attrib.graphics.endFill();
		}

	}
}