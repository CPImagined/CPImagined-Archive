package com.clubpenguin.games.container
{
	import com.clubpenguin.lib.IDisposable;
	import com.disney.lib.IUniquelyNamable;
	import flash.utils.Dictionary;

	public class Container implements IDisposable,IUniquelyNamable
	{
		private static var $_instanceCount:int = -1;

		protected var _uid:int;
		
		protected var _objects:Dictionary;

		public function Container()
		{
			super();
			
			this._uid = ++$_instanceCount;
		
			this._objects = new Dictionary();
		}
		
		public function addObject(obj:Object, objName:String):void
		{
			trace(this.getUniqueName() + " adding new object: " + obj + " with key: " + objName);
			
			this._objects[objName] = obj;
		}
		
		public function removeObject(objName:String):void
		{
			trace(this.getUniqueName() + " deleting existing object: " + objName);
		
			delete this._objects[objName];
		}
		
		public function getObj(objName:String):Object
		{
			return this._objects[objName];
		}

		public function updateAll():void
		{
			this.callOnAllObjs("update");
		}
		
		public function callOnObj(objName:String, funcName:String):void
		{
			var object = this._objects[objName];
			
			if (object != null && object.hasOwnProperty(funcName))
			{
				object[funcName]();
			}
		}
		
		public function callOnAllObjs(funcName:String):void
		{
			for each (var object in this._objects)
			{
				if (object.hasOwnProperty(funcName))
				{
					object[funcName]();
				}
			}
		}

		public function dispose():void
		{
			this.callOnAllObjs("dispose");
			
			this._objects = null;
		}
		
		public function getUniqueName():String
		{
			return "[Container" + this._uid + "]";
		}
	}
}