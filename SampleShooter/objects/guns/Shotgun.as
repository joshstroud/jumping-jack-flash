package objects.guns
{
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import objects.Gun;

	public class Shotgun extends Gun
	{
		[Embed(source="media/shotgun_reload.mp3")]
		private var reloadSnd:Class;
		
		
		protected var _numBulletsPerShot:Number = 12;
		protected var _origCooldown:Number;
		protected var _bulletCount:Number = 0;
		private var s_reload:Sound = new reloadSnd as Sound;
		
		public function Shotgun()
		{
			accuracy = 50;
			super();
			_cooldownTimer = 44;
			_gTimer.reset();
			_gTimer = new Timer(_cooldownTimer * _frameRate);
			_gTimer.start();
			_gTimer.addEventListener(TimerEvent.TIMER, onGunTimer, false, 0, true); 
		}
		
		override protected function updateCooldown(increase:Boolean):void {
			if(_bulletCount == _numBulletsPerShot && !increase) {
				_cooldown = 0;
				_bulletCount = 0;
			} else if (!increase) 
				_bulletCount++;
			else {
				_cooldown++;
				trace(_cooldown);
			}
		}
		
		override protected function _fire(modFactor:Number = 0, cooldown_on:Number = 1):Boolean {
			if(_cooldown >= _cooldownTimer) {
				
				for(var i:int = 0; i < _numBulletsPerShot; i++) {
					super._fire(modFactor + i*(Math.random() - 0.5))
				}
				s_reload.play();
				return true;
			}
			updateCooldown(true);
			return false;
		}
		
		
		
		
	}
}