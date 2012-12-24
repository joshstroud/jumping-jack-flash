package abstract.genes
{
	import abstract.GeneContainer;

	public class Gene
	{
		///***** START CONSTANT GENE TYPES *****///
		private static const G_SPD:String = "speed";
		private static const G_STR:String = "strength";
		private static const G_NULL:String = "null";
		private static const G_RND:String = "random";
		
		private static const G_TYPES:Array = [G_SPD, G_STR];
		///***** END CONSTANT GENE TYPES *****///
		
		private var _geneType:String;
		private var _genePower:Number;
		
		public function Gene(gType:String = G_NULL, gPower:Number = 1)
		{
			if(gType == G_RND)
				gType = rndGeneType();
			_geneType = gType;
			_genePower = gPower;
		}

		public function get geneType():String {
			return _geneType;
		}
		
		public function get genePower():Number {
			return _genePower;
		}
		
		private function rndGeneType():String {
			var rnd:Number = Math.floor(Math.random()*G_TYPES.length);	// returns random integer between 1 and G_TYPES.length
			trace(rnd);
			var gType:String = G_TYPES[rnd];
			return gType;
		}
		
	}
}