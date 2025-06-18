package com.clubpenguin.game
{
	import com.clubpenguin.lib.vo.IEndGameVO;
	import com.clubpenguin.lib.vo.IPlayerVO;
	import com.clubpenguin.lib.vo.MPGameVO;
	import com.disney.coupler.ICouplerHost;
	import org.osflash.signals.Signal;

	public interface ICPHost extends ICouplerHost
	{
		function getLocale():int;

		function getPlayerVO():IPlayerVO;

		function showEndGame(endGameVO:IEndGameVO):void;
		
		function getBaseConfigPath(): String;

		function getBasePath():String;

		function showMembershipPrompt(_filename:String, _biTag:String = null):void;

		function isMusicMuted():Boolean;

		function stampEarned(_stampID:int, _isServerSide:Boolean = false):void;

		function isStampEarned(_stampID:int):Boolean;

		function levelComplete(_level:int):void;

		function levelStart(_level:int):void;

		function requestFPS(_fps:int):Boolean;
		
		function setQuality(_qual:String):void;
		
		function getQuality():String;

		function getPlayerColor():int;

		function purchaseItem(itemID:int):void;

		function getDoesPlayerOwnItem(itemID:int):Signal;

		function playMusic(musicID:int):void;

		function getGameStartParams():Object;

		function launchMPGame(game:MPGameVO):void;
	}
}