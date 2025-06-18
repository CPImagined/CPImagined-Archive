package com.clubpenguin.lib.vo.ext
{
	import com.clubpenguin.lib.vo.EndGameVO;
	import com.disney.lib.IDisposable;
	
	// An extension to clean up non-primitives to prevent memory leaks
	public class EndGameVOExt extends EndGameVO implements IDisposable
	{
		public function dispose():void
		{
			this.setGameCompletedParams(null);
		}
	}
}