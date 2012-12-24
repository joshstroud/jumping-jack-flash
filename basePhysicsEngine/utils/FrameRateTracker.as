package utils
{
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	public class FrameRateTracker extends TextField
	{
		private var _fps:Number;
		private var _prevTime:Number = 0;
		private var _prevFps:Array = [];		// saves the fps for the last 60 frames as an array
		
		public function FrameRateTracker(fps:Number = 30)
		{
			_fps = fps;
			this.selectable = false;
		}
		
		public function update():void {
			var currentTime:Number = getTimer();
			var fps:Number = 1000 / (currentTime - _prevTime);
			_prevTime = getTimer();
			_fps = fps;
		//	_prevFps.push(fps);
		//	if (_prevFps.length >= 60) {
		//		var calc:Number = (_prevFps[0]+_prevFps[1])/2;
		//		for (var i:int = 0; i < _prevFps.length - 1; i++) {
		//			calc = (calc + _prevFps[i+1])/2;
		//		}
		//		fps = calc;
		//		_prevFps = new Array();
		//	}
		
		}
		
		public function get fps():Number {
			return _fps;
		}
		
		public function printFPS():Number {
			var oldfps:Number = _fps;
			this.update();
			_fps = int ( (_fps + oldfps) >> 1 + 0.5); 	/// optimized version of Math.Round( (fps+oldfps)/2 )
	//		trace('fps: ' + fps);
			this.text = String(fps);
			return _fps;
		//	numObjs_text.text = String(findNumObjects());
		}
		
	}
}