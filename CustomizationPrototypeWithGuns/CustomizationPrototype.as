package {
	import components.*;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import guns.*;
	import guns.attribs.*;

	public class CustomizationPrototype extends Sprite
	{
		private var pointsLeft:TextField;
		private var numPoints:Number = 0;
		private var menus:Array;
		private var gun:BaseGun = new BaseGun();
			
		
		public function CustomizationPrototype()
		{
			menus = new Array();
			var container:Sprite = new Sprite;
			addChild(container);
			container.addChild(gun);
			
			var menuClass:Menu = new Menu(Consts.GCLASS, Consts.GCLASS_ARRAY, 0);
			var menuSize:Menu = new Menu(Consts.GSIZE, Consts.GSIZE_ARRAY, 0);
			var menuSpec:Menu = new Menu(Consts.GSPEC, Consts.GSPEC_ARRAY, 0)
			menus.push(menuClass, menuSize, menuSpec);
			
			var i:int = 0
			for each (var menu:Menu in menus) {
				gun._gAttributeArray[i].addChild(menus[i]);
				//var menu:Menu = new Menu('fail '+ String(i), ['I','went','to','the','zoo'], 0);		// returns name of string
				//var attrib:BaseAttrib = new BaseAttrib(BaseAttrib.ATTRIB_ARRAY[i],1);
				//attrib.addChild(menu)
				//gun.addChild(attrib);
				menu.x = 150;
				menu.y = 100+50*i;
				gun._gAttributeArray[i].addEventListener(MenuEvent.ARROW_CLICKED, changeAttrib);
				i++;
			}
			
	//		var label:TextField = new TextField();
	//		label.selectable = false
	//		label.autoSize = "left"
	//		label.text = "Attribute points left:"
	//		label.y = 50;
	//		label.x = 230;
	//		container.addChildAt(label,1);
			
			if (numPoints <= 0)	// if pointsLeft <=0, then disable
				return;
			pointsLeft = new TextField();
			pointsLeft.selectable = false;
			pointsLeft.text = String(numPoints)
			container.addChildAt(pointsLeft,0);
			pointsLeft.x = 300
			pointsLeft.y = 50
		}
		
		public function changeAttrib(e:MenuEvent):void {
			//trace(e.currentTarget);
			e.currentTarget.create(e.currentTarget.type, e.target.value, e.currentTarget.value);

			//trace(attrib.type +' ' + attrib.subtype + ', '+attrib.value);
			if (numPoints <=0)
				return;
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
