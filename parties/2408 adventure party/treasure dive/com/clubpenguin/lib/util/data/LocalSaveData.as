package com.clubpenguin.lib.util.data
{
	import com.clubpenguin.lib.IDisposable;
	import com.clubpenguin.game.HostAccess;
	import com.disney.lib.IUniquelyNamable;
	import flash.net.SharedObject;

	public class LocalSaveData implements IDisposable,IUniquelyNamable
	{
		private var __dataId:String;
		private var __localSharedObj:SharedObject;
		private var __localPlayerId:int;

		public function LocalSaveData(_dataId:String):void
		{
			if (_dataId != null && _dataId != "")
			{
				this.__dataId = _dataId;
				this.__localPlayerId = HostAccess.getHost().getPlayerVO().getPlayerId();

				this.__localSharedObj = SharedObject.getLocal(this.__dataId);
			}
		}
		
		public function dispose():void
		{
			this.write();
			
			this.__localSharedObj = null;
		}

		public function updateData(_data:Object,_writeNow:Boolean):Boolean
		{
			// Updates the save data, and writes the changes to disk if we say to.

			trace(this.getUniqueName() + " Updating local data. Saving to disk immediately? " + _writeNow);

			this.__localSharedObj.data[this.__localPlayerId] = _data;

			if (_writeNow)
			{
				return this.write();
			}
			return true;
		}

		public function getData():Object
		{
			var objData = this.__localSharedObj.data[this.__localPlayerId];
			if (objData != null)
			{
				return objData;
			}
			return {};
		}

		public function clearData(_writeNow:Boolean):Boolean
		{
			// Erases the save data, and writes the changes to disk if we say to.

			trace(this.getUniqueName() + " Erasing local data. Saving to disk immediately? " + _writeNow);

			this.__localSharedObj.data[this.__localPlayerId].clear();

			if (_writeNow)
			{
				return this.write();
			}
			return true;
		}

		public function write():void
		{
			// Writes save data out to disk.

			var res = this.__localSharedObj.flush();
			if (!res)
			{
				trace(this.getUniqueName() + " Failed to save to disk! User disallowed local storage.");
			}
			return res;
		}
		
		public function getUniqueName():String
		{
			return "[LocalSaveData" + this.__dataId + "]";
		}
	}
}