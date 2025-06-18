package com.clubpenguin.lib.locale
{
	import com.disney.lib.IDisposable;
	import flash.display.DisplayObject;
	import org.osflash.signals.ISignal;

	public interface ILocaleHandler extends IDisposable
	{
		function getString(_key:String):String;

		function getImage(_assetKey:String, _sourceKey:String = "locale"):DisplayObject;

		function getSignalLoadComplete():ISignal;

		function setLocaleByID(_localeID:int):void;

		function setLocaleByName(_localeName:String):void;

		function load(_loadCompleteCallback:Function):void;
		
		function setGameID(_gameID:int):void;

		function getLocaleID():int;

		function getLocaleName():String;

		function setLocaleAssetNames(_localeAssetNames:Array):void;

		function setGameURL(_gameURL:String):void;
	}
}