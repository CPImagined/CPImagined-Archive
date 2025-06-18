package 
{
	import com.clubpenguin.games.chase.ChaseEngine;
	import com.clubpenguin.coupler.GameCouplerCP;

	public class ChaseCP extends GameCouplerCP
	{
		public function ChaseCP()
		{
			super();
			
			// Hack to force engine to be instantiated
			ChaseEngine;
		}

		override public function getConfigName():String
		{
			return "chase_" + super.getConfigName();
		}
	}
}