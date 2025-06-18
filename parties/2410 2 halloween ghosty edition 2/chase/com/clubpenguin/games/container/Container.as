package com.clubpenguin.games.container
{
	import com.disney.lib.*;
	import flash.utils.Dictionary;
	import org.osmf.logging.Log;

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
			Log.getLogger(this.getUniqueName()).debug("Adding new object: " + obj + " with key: " + objName);
			
			this._objects[objName] = obj;
		}
		
		public function removeObject(objName:String):void
		{
			Log.getLogger(this.getUniqueName()).debug("Deleting existing object: " + objName);
		
			delete this._objects[objName];
		}
		
		public function getObj(objName:String):Object
		{
			return this._objects[objName];
		}
		
		public function get objects():Dictionary
		{
			return this._objects;
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
				Log.getLogger(this.getUniqueName()).debug("Calling " + funcName + " on object " + object);
				
				object[funcName]();
			}
		}
		
		public function callOnAllObjs(funcName:String):void
		{
			for each (var object in this._objects)
			{
				if (object.hasOwnProperty(funcName))
				{
					Log.getLogger(this.getUniqueName()).debug("Calling " + funcName + " on object " + object);
					
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
			return "Container" + this._uid;
		}
	}
}