package com.clubpenguin.games.diving
{
	import flash.display.MovieClip;

	public class Bubble extends MovieClip
	{
		public function Bubble()
		{
			super();
			
			this.addFrameScript(58, this.stop);
		}
		
		public function dispose():void
		{
			this.parent.removeChild(this);
		}
	}
}