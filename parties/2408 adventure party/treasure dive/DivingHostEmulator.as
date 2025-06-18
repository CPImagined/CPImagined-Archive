package 
{
	import com.clubpenguin.CPHostEmulator;

	public class DivingHostEmulator extends CPHostEmulator
	{
		public function DivingHostEmulator()
		{
			super();
		}

		override protected function getHostGameName():String
		{
			return "diving.swf";
		}
		
		override public function getGameStartParams():Object
		{
			/*
			Unfortunately we can only check every puffle the player has.
			We want to see specifically which puffle the player is walking,
			so the AS2 environment will have to tell us if we're walking a brown puffle.
			*/
			
			return {hasBrownPuffle: true};
		}
	}
}