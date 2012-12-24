package guns
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import guns.attribs.*;
	
	public class BaseGun extends Sprite
	{
		public var _gClass:BaseAttrib;
		public var _gSize:BaseAttrib;
		public var _gSpec:BaseAttrib;
		public var _gAttributeArray:Array;
		
		private var _gWidth:Number = 100;
		private var _gColor:Number = 0x000000
		private var _gSpecAttachment:String = ""
		private var _baseBitmap:Bitmap;

		public function BaseGun()
		{
			this.addEventListener(AttribEvent.ATTRIB_CHANGE_VALUE, onAttribChange);
			this.addEventListener(AttribEvent.ATTRIB_CREATED, onAttribChange);
		
			_gClass = new BaseAttrib(Consts.GCLASS, Consts.GCLASS_ARRAY[0], 1);		
			_gSize = new BaseAttrib(Consts.GSIZE, Consts.GSIZE_ARRAY[0], 1);
			_gSpec = new BaseAttrib(Consts.GSPEC, Consts.GSPEC_ARRAY[0], 1);
			_gAttributeArray = [_gClass, _gSize, _gSpec]
		
			for each (var att:BaseAttrib in _gAttributeArray) {
				this.addChild(att);
				att.dispatchEvent(new AttribEvent(AttribEvent.ATTRIB_CREATED));
			}
					
		}

		public function onAttribChange(e:AttribEvent):void {
			var attrib:BaseAttrib = e.target as BaseAttrib;
			//var color = 0x000000
			trace('Changed to ' + e.target.type + ' ' + e.target.subtype + ' of value ' + e.target.value);
			switch(e.target.type) {
				case Consts.GCLASS:
					onGClassChange(e);
					break;
				case Consts.GSIZE:
					onGSizeChange(e);
					break;
				case Consts.GSPEC:
					onGSpecChange(e);
					break;
			}
			drawGun(e)
			_gAttributeArray = [_gClass, _gSize, _gSpec]
		}
	
		private function onGClassChange(e:AttribEvent):void {		// e.target in these cases would be gun._gClass, etc.
			var subtype:String = e.target.subtype;
			switch(subtype){
				case Consts.GCLASS_LASER:
					_gColor = 0xff0000
					break;
				case Consts.GCLASS_PARTICLE:
					_gColor = 0x00ff00
					break;
				case Consts.GCLASS_SONIC:
					_gColor = 0x0000ff
					break;
			}
		}
	
		private function onGSizeChange(e:AttribEvent):void {
			var subtype:String = e.target.subtype;
			switch(subtype){
				case Consts.GSIZE_LIGHT:
					_gWidth = 80;
					break;
				case Consts.GSIZE_BALANCED:
					_gWidth = 120;
					break;
				case Consts.GSIZE_HEAVY:
					_gWidth = 180;
					break;
			}
		}
	
		private function onGSpecChange(e:AttribEvent):void {
			var subtype:String = e.target.subtype;
			switch(subtype){
				case Consts.GSPEC_ACC:
					_gSpecAttachment = "Scope"
					break;
				case Consts.GSPEC_PWR:
					_gSpecAttachment = "PowerRings"
					break;
				case Consts.GSPEC_SPD:
					_gSpecAttachment = "SpeedTriangles"
					break;
			}
		}
		
		private function drawGun(e:AttribEvent):void {
			for each (var att:BaseAttrib in _gAttributeArray) {
				att.graphics.clear();
			}
			trace('plum'+_gSpecAttachment);
			e.target.graphics.beginFill(_gColor)
			var size:Number = _gWidth;
			_gWidth = 120;
			e.target.graphics.drawRect((150-_gWidth/2)/2,150,_gWidth,_gWidth/8);
			e.target.graphics.endFill();
			
			e.target.graphics.beginFill(0x000000)
			switch(_gSpecAttachment){
				case "Scope":
					e.target.graphics.drawRect( (140-_gWidth/2)/2 + 40,145, _gWidth/2, _gWidth/12); 
					break;
				case "PowerRings":
					e.target.graphics.drawRect( (140-_gWidth/2)/2 + 40,145, _gWidth/15, _gWidth/10);
					e.target.graphics.drawRect( (160-_gWidth/2)/2 + 40,145, _gWidth/15, _gWidth/10);
					e.target.graphics.drawRect( (180-_gWidth/2)/2 + 40,145, _gWidth/15, _gWidth/10);
					e.target.graphics.drawRect( (200-_gWidth/2)/2 + 40,145, _gWidth/15, _gWidth/10);
					
					break;
				case "SpeedTriangles":
					e.target.graphics.drawCircle((150-_gWidth/3)/2, 146.5 + _gWidth/10, _gWidth / 25)
					e.target.graphics.drawCircle((150-_gWidth/1.4/3)/2, 146.5 + _gWidth/10, _gWidth / 25)
					e.target.graphics.drawCircle((150-_gWidth/1.4/6)/2, 146.5 + _gWidth/10, _gWidth / 25)
					break;
			}
			e.target.graphics.endFill()
			e.target.scaleX = e.target.scaleY = size/100;
		}
		
	//	private gunDrawGunBitmap():void {
	///		return;
	//		//this.gr
	//	}
		
	}
}