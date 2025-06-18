package 
{
	import com.clubpenguin.games.diving.DivingEngine;
	import com.clubpenguin.coupler.GameCouplerCP;

	public class DivingCP extends GameCouplerCP
	{
		public function DivingCP()
		{
			super();
		}
		
		override public function getConfigName():String
		{
			return "diving_" + super.getConfigName();
		}
	}

}