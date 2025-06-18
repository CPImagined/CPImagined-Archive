package com.clubpenguin.lib.security
{
	import flash.display.DisplayObject;
	import org.osflash.signals.ISignal;

	public interface ISecurityHandler
	{
		function doSecurityCheck(_content:DisplayObject):void;

		function getSecurityCheckSuccess():ISignal;
	}
}