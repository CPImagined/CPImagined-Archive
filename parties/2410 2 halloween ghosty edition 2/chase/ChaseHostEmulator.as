package 
{
	import com.clubpenguin.CPHostEmulator;

	public class ChaseHostEmulator extends CPHostEmulator
	{
		public function ChaseHostEmulator()
		{
			super();
		}
		
		override public function getPlayerColor():int
		{
			// Override to test how different colors look.
			return 16737792;
		}

		override protected function getHostGameName():String
		{
			return "chase.swf";
		}
		
		override public function getGameStartParams():Object
		{
			/*
			Unfortunately we can only check every puffle the player has.
			We want to see specifically which puffle the player is walking,
			so the AS2 environment will have to tell us if we're walking a ghost puffle.
			
			Params for this game (all are optional):
			- useGhostPuffle: see above
			- itemId: see ChaseEngine for possible values
			- keyId: see ChaseEngine for possible values
			*/
			
			return {useGhostPuffle: true, itemId: 93049, keyId: 11};
		}
	}
}