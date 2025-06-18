package com.clubpenguin.game
{
	import org.osflash.signals.ISignal;

	public interface ICPMultiplayer
	{
		function getResponded():ISignal;

		// "s" is PLAY_EXT in AIRTOWER
		function sendMessage(msgCategory:String,msgType:String,msgArgs:Array=null,extension:String="s"):void;
	}
}