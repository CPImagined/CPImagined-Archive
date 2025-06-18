package com.clubpenguin.game
{
	import flash.display.DisplayObject;

	public interface ICPGameHost extends ICPHost
	{
		function localizeString(_stringID:String):String;

		function localizeImage(_imageID:String):DisplayObject;
	}
}