package keyboard
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import keyboard.source.KeyPoll;
	
	public class KeyPoller extends DisplayObject
	{
		private static var leftKeyPress:String = "leftKeyPress";
		private static var rightKeyPress:String = "rightKeyPress";	
		private static var upKeyPress:String = "upKeyPress";
		private static var downKeyPress:String = "downKeyPress";
		private static var keyPoll:KeyPoll;
		private static var keysToCheck:Array;
	
		public function KeyPoller()
		{
			keyPoll = new KeyPoll(this.root);
			this.parent.root.addEventListener(KeyboardEvent.KEY_DOWN, checkKeyPoll);
		}


		public function checkKeyPoll():void {
		  for each (var key:Number in keysToCheck) {
		  	if (keyPoll.isDown(key)) {
		  		this.dispatchEvent(new Event(numToChar(key) + 'press'));
		  	}
		  }
		  
		}
	
	public function addKey(key:Number):void { //PUSH AS KEYCODE, NOT KEY i.e. '32', not 'a'
		keysToGet.push(key);
	}
	
	//getters
	public function get upKeyPress():String {
		return upKeyPress;
	}
	
	public function get leftKeyPress():String {
		return leftKeyPress
	}
	
	public function get rightKeyPRess():String {
		return rightKeyPress;
	}
	
	public function get downKeyPress():String {
		return downKeyPress;
	}
	
	public function get keysToGet():Array {
		return keysToGet;
	}

	  private function numToChar(num:int):String {
        if (num > 47 && num < 58) {
            var strNums:String = "0123456789";
            return strNums.charAt(num - 48);
        } else if (num > 64 && num < 91) {
            var strCaps:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return strCaps.charAt(num - 65);
        } else if (num > 96 && num < 123) {
            var strLow:String = "abcdefghijklmnopqrstuvwxyz";
            return strLow.charAt(num - 97);
        } else {
            return num.toString();
        }
    }        
    
	}
}