package com.clubpenguin.lib.util.collection
{
	import com.clubpenguin.lib.vo.IVO;
	import org.osflash.signals.Signal;

	public interface ICollection
	{
		function destroy(destroyItems:Boolean = false):void;

		function getType():Class;

		function getSize():int;

		function isEmpty():Boolean;

		function add(item:IVO):Boolean;

		function removeItem(item:IVO, destroyItem:Boolean = false):void;

		function remove(itemList:Array, destroyItems:Boolean = false):void;

		function clear(destroyItems:Boolean = false):void;

		function getAllItems():Array;

		function getItem(itemID:int):IVO;

		function toString():String;

		function getItemAdded():Signal;

		function getItemRemoved():Signal;
	}
}