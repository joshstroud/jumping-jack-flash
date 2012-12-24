package components
{
	import fl.controls.NumericStepper;
	
	public class NumericStepperX extends NumericStepper
	{
		public function NumericStepperX(min:Number=0, max:Number=2, stepSize:Number=.2, value:Number=1)
		{
			super();
			this.stepSize = stepSize;
			this.minimum = min;
			this.maximum = max;
			this.value = value;
		}
		
	}
}