package {
	import components.*;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import guns.*;
	import guns.attribs.BaseAttrib;

	public class CustomizationPrototype extends Sprite
	{
		private var pointsLeft:TextField;
		private var numPoints:Number = 7;
		private var menus:Array
		private var gun:BaseGun = new BaseGun();
			
		
		public function CustomizationPrototype()
		{
			menus = new Array();
			var container:Sprite = new Sprite;
			addChild(container);
			container.addChild(gun);
			
			for (var i:int = 0; i < BaseAttrib.ATTRIB_ARRAY.length; i++) {
				var menu:Menu = new Menu('fail '+ String(i), ['1','2','3','4','5','6','7','8','9'], 0);		// returns name of string
				//var menu:Menu = new Menu('fail '+ String(i), ['I','went','to','the','zoo'], 0);		// returns name of string
				menus.push(menu)
				var attrib:BaseAttrib = new BaseAttrib(BaseAttrib.ATTRIB_ARRAY[i],1);
				attrib.addChild(menu)
				gun.addChild(attrib);
				menu.x = 150;
				menu.y = 100+50*i;
				attrib.addEventListener(MenuEvent.ARROW_CLICKED, changeAttrib);
			}
			
	//		var label:TextField = new TextField();
	//		label.selectable = false
	//		label.autoSize = "left"
	//		label.text = "Attribute points left:"
	//		label.y = 50;
	//		label.x = 230;
	//		container.addChildAt(label,1);
			
			pointsLeft = new TextField();
			pointsLeft.selectable = false;
			pointsLeft.text = String(numPoints)
			container.addChildAt(pointsLeft,0);
			pointsLeft.x = 300
			pointsLeft.y = 50
		}
		
		public function changeAttrib(e:MenuEvent):void {
			//trace(e.currentTarget);
			var attrib:BaseAttrib = e.currentTarget as BaseAttrib;
			if (e.direction == MenuEvent.LEFT)
				attrib.value --;
			else if (e.direction == MenuEvent.RIGHT)
				attrib.value ++;
			trace(attrib.type +', '+attrib.value);
			checkForPoints(e);
		}
		
		public function checkForPoints(e:MenuEvent):void {
			var bool:Boolean = false;
			
			if(e.direction == MenuEvent.LEFT)
				pointsLeft.text = String( Number(pointsLeft.text) +1 );
			if(e.direction == MenuEvent.RIGHT)
				pointsLeft.text = String( Number(pointsLeft.text) - 1 );
			trace('points left: ' + pointsLeft.text);
			
			if ( pointsLeft.text == '0')
				bool = true
			for each (var menu:Menu in menus) {
					menu._disableRightArrow = bool;			
			}
		}
		
		
	}
}
