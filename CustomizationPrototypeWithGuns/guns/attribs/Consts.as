package guns.attribs
{
	public class Consts
	{
		// gun general types
		public static const GCLASS:String = "Class";
		public static const GSIZE:String = "Size";
		public static const GSPEC:String = "Spec";
		public static const G_ARRAY_TYPES:Array = [GCLASS, GSIZE, GSPEC] 	// needed for sorting purposes
		
		// gun projectile subtypes
		public static const GCLASS_PARTICLE:String = "Particle"
		public static const GCLASS_LASER:String = "Laser"
		public static const GCLASS_SONIC:String = "Sonic"
		public static const GCLASS_ARRAY:Array = [GCLASS_PARTICLE, GCLASS_LASER, GCLASS_SONIC]
		
		
		// gun size subtypes
		public static const GSIZE_LIGHT:String = "Light"
		public static const GSIZE_BALANCED:String = "Balanced"
		public static const GSIZE_HEAVY:String = "Heavy"
		public static const GSIZE_ARRAY:Array = [GSIZE_LIGHT, GSIZE_BALANCED, GSIZE_HEAVY]
		
		// gun specialization subtypes
		public static const GSPEC_PWR:String = "Power";
		public static const GSPEC_SPD:String = "Speed";
		public static const GSPEC_ACC:String = "Accuracy";
		public static const GSPEC_ARRAY:Array = [GSPEC_PWR, GSPEC_SPD, GSPEC_ACC]
		
		public function Consts()
		{
		}

	}
}