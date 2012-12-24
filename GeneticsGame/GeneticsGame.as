package {
	import abstract.*;
	import abstract.genes.*;
	import object.PhysicsObject;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class GeneticsGame extends Sprite
	{
		internal var gc:GeneContainer
		
		public function GeneticsGame()
		{
			gc = new GeneContainer(9);
			var ars:Sprite = new Sprite();
			this.addChild(ars);
			var color:Number;
			for (var i:int = 0; i< gc.genes.length; i++) {
				var g:Gene = gc.genes[i];
				var mc:Sprite = new Sprite;
				switch(g.geneType) {
					case 'strength':
					color = 0x30960B;
					break;
					case 'speed':
					color = 0xC41603;
					break;
				}
				//gfx
				mc.graphics.beginFill(color);
				mc.graphics.drawRect(0,0, this.stage.stageWidth/gc.genes.length*i, this.stage.stageHeight/gc.genes.length*i);
				mc.alpha = i/10;
				mc.graphics.endFill();
				this.addChildAt(mc, 0);	
			}
				
		}
	}
}
