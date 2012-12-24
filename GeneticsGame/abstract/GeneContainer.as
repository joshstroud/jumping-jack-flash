package abstract
{
	import abstract.genes.*;
	
	public class GeneContainer
	{
		///***** START CONSTANT GENE TYPES *****///
		private static const G_SPD:String = "speed";
		private static const G_STR:String = "strength";
		private static const G_NULL:String = "null";
		private static const G_RND:String = "random";
		
		private static const G_TYPES:Array = [G_SPD, G_STR];
		///***** END CONSTANT GENE TYPES *****///
		
		
		private var _genesArray:Array;
				
		public function GeneContainer(gNum:Number = 10, gType:String = G_RND) 
		{
			_genesArray = new Array();
			createGenes(gType, 1, gNum);
		}
		
		public function get genes():Array {
			return _genesArray;
		}
			// probably should't make this accessible. use below functions instead
	
		public function createGenes(gType:String, gPower:Number, gNum:Number = 1):void {
			for(var i:int = 0; i < gNum; i++) {
				_genesArray.push(new Gene(gType, gPower));
			}
		}
		
		public function getTypes(startIndex:Number = 0, endIndex:Number = 0):Array {
			var gArray:Array = new Array();
			if (endIndex == 0) 
				endIndex = _genesArray.length;
			for(var i:int = startIndex; i <= endIndex; i++) {
				gArray.push(_genesArray[i].geneType);
			}
			return gArray;
		}
		
		public function removeGene(gType:String):void {
			var gIndex:Number = findGeneIndex(gType);
			if (gIndex != -1) {
				_genesArray.splice(gType, 1);
			}
		}

		
		
		private function findGeneIndex(gType:String):Number {    //if this returns -1, then NO OBJECT FOUND
			return _genesArray.indexOf(new Gene(gType));
		}
		
		
	}
}