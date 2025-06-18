package com.clubpenguin.lib.locale.ext
{
	import com.disney.lib.*;
	import com.disney.loader.ext.ILoader;
	import org.osflash.signals.Signal;
	import flash.utils.getDefinitionByName;
	import org.osmf.logging.Log;

	internal class LocaleObjectLoader implements IUniquelyNamable,IDisposable
	{
		private const __complete:Signal = new Signal(Boolean);

		private var __localeDir:String;

		private var __objNames:Array;

		protected var __loadedObjs:Array;

		private var __currIndex:int;
		
		private var __loader:ILoader;

		protected var __success:Boolean;

		public function LocaleObjectLoader()
		{
			super();
		}

		public function load(_localeDir:String,_objNames:Array,_loadedObjs:Array):void
		{
			Log.getLogger(this.getUniqueName()).debug("Loading locale objects from: " + _localeDir);
			
			this.__currIndex = -1;

			this.__loadedObjs = _loadedObjs;
			this.__localeDir = _localeDir;
			this.__objNames = _objNames;

			this.__success = true;

			this.loadNextObj();
		}

		protected function loadNextObj():void
		{
			++this.__currIndex;
			if (this.__currIndex >= this.__objNames.length)
			{
				Log.getLogger(this.getUniqueName()).debug("Locale objects loaded " + (this.__success ? "successfully!" : "unsuccessfully!"));
				
				this.__loader = null;
				this.__complete.dispatch(this.__success);
			}
			else
			{
				try
				{	
					var loaderClass = getDefinitionByName(this.loader_class) as Class;
					this.__loader = new loaderClass(this.__localeDir + this.__objNames[this.__currIndex] + this.locale_obj_filetype,this.objLoadedCallback);
				}
				catch (e:Error)
				{
					Log.getLogger(this.getUniqueName()).error("Failed loading: " + __objNames[__currIndex] + "\n" + e.getStackTrace());
					
					this.__success = false;
					this.loadNextObj();
				}
			}
		}

		private function objLoadedCallback(_loadedObj:Object):void
		{
			if (_loadedObj != null)
			{
				this.handleObjectLoaded(_loadedObj);
			}
			else
			{
				
				Log.getLogger(this.getUniqueName()).error("Failed loading: " + this.__localeDir + this.__objNames[this.__currIndex] + this.locale_obj_filetype + " came back as null!");
				this.__success = false;
			}
			
			this.loadNextObj();
		}

		protected function handleObjectLoaded(_loadedObj:Object):void
		{
			if (this.__loadedObjs[this.__objNames[this.__currIndex]] == null)
			{
				Log.getLogger(this.getUniqueName()).debug("Loaded: " + this.__localeDir + this.__objNames[this.__currIndex] + this.locale_obj_filetype);
				this.__loadedObjs[this.__objNames[this.__currIndex]] = _loadedObj;
			}
			else
			{
				Log.getLogger(this.getUniqueName()).error("Found duplicate entry for asset: " + this.__objNames[this.__currIndex]);
				this.__success = false;
			}
		}

		public function get complete():Signal
		{
			return this.__complete;
		}

		protected function get locale_obj_filetype():String
		{
			return "";
		}

		protected function get loader_class():String
		{
			return "";
		}
		
		public function getUniqueName():String
		{
			return "LocaleObjectLoader";
		}
		
		public function dispose():void
		{
			this.__complete.removeAll();

			this.__objNames = null;
			this.__loadedObjs = null;
			
			this.__loader = null;
		}
	}
}