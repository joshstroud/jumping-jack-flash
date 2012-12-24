package components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class Menu extends Sprite
	{
		private var _valueList:Array;
		private var _place:Number;
		private var _value:TextField;
		public var _disableLeftArrow:Boolean = false;
		public var _disableRightArrow:Boolean = false;
		
		
		public function Menu(header_str:String, valueList:Array, valueStart:Number) {
			_valueList = valueList
			_place = valueStart;
			this.name = header_str;
			var leftArrow:Sprite = new Sprite();
			this.addChild(leftArrow);
			leftArrow.graphics.beginFill(0x222222);
			leftArrow.graphics.drawRect(0, 0, 20, 12);
			leftArrow.graphics.endFill();
			leftArrow.addEventListener(MouseEvent.CLICK, leftArrowClick);
			leftArrow.x = 100;
			
			var rightArrow:Sprite = new Sprite();
			this.addChild(rightArrow);
			rightArrow.graphics.beginFill(0x222222);
			rightArrow.graphics.drawRect(0, 0, 20, 12);
			rightArrow.graphics.endFill();
			rightArrow.addEventListener(MouseEvent.CLICK, rightArrowClick);
			rightArrow.x = 180;

			
			var header:TextField = new TextField();
			header.htmlText = "<b>" + header_str + "</b>";

		//	header.scaleX = header.scaleY = 
			header.selectable = false;
			header.autoSize = "center"
			header.x = (rightArrow.x + leftArrow.x) / 2 - 5;
			header.y = -21;
			this.addChildAt(header, 0);
			
			_value = new TextField();
			_value.selectable = false;
			_value.text = _valueList[_place];		// dont use htmltext here, use textformat instead
			_value.x = header.x;
			_value.y = -3;
			//_value.autoSize = "center"
			this.addChildAt(_value, 0);
		}
		
		public function leftArrowClick(e:MouseEvent):void {
			if(_valueList[_place] == _valueList[0] || _disableLeftArrow)
				return;
			else
				_place--;
			this._value.htmlText = _valueList[_place];
			this.dispatchEvent(new MenuEvent(MenuEvent.ARROW_CLICKED, MenuEvent.LEFT));
		}
		
		public function rightArrowClick(e:MouseEvent):void {
			if(_valueList[_place] == _valueList[_valueList.length - 1] || _disableRightArrow)
				return;
			else
				_place++;
			this._value.htmlText = _valueList[_place];
			this.dispatchEvent(new MenuEvent(MenuEvent.ARROW_CLICKED, MenuEvent.RIGHT));
		}
		
		public function get value():String {
			return _value.text;
		}

	}
}