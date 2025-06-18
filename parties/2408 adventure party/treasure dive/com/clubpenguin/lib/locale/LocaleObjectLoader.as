package com.clubpenguin.lib.locale
{
	import com.disney.lib.IUniquelyNamable;
	import com.disney.loader.LoaderBase;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import flash.utils.getDefinitionByName;

	internal class LocaleObjectLoader implements IUniquelyNamable
	{
		private const __complete:Signal = new Signal(Boolean);

		private var __localeDir:String;

		private var __objNames:Array;

		protected var __loadedObjs:Array;

		private var __currIndex:int;

		private var __loader:LoaderBase;

		protected var __success:Boolean;

		public function LocaleObjectLoader()
		{
			super();
		}

		public function load(_localeDir:String,_objNames:Array,_loadedObjs:Array):void
		{
			trace(this.getUniqueName() + " Loading locale objects from: " + _localeDir);
			
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
				trace(this.getUniqueName() + " Locale objects loaded " + (this.__success ? "successfully!" : "unsuccessfully!"));
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
					trace(this.getUniqueName() + " ERROR in loading asset name: " + __objNames[__currIndex] + "\n" + e.getStackTrace());
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
				trace(this.getUniqueName() + " ERROR an error occured in loading: " + this.__localeDir + this.__objNames[this.__currIndex] + this.locale_obj_filetype + " came back as null!");
				this.__success = false;
			}
			
			this.loadNextObj();
		}

		protected function handleObjectLoaded(_loadedObj:Object):void
		{
			if (this.__loadedObjs[this.__objNames[this.__currIndex]] == null)
			{
				trace(this.getUniqueName() + " Loaded: " + this.__localeDir + this.__objNames[this.__currIndex] + this.locale_obj_filetype);
				this.__loadedObjs[this.__objNames[this.__currIndex]] = _loadedObj;
			}
			else
			{
				trace(this.getUniqueName() + " ERROR found duplicate entry for asset: " + this.__objNames[this.__currIndex]);
				this.__success = false;
			}
		}

		public function get complete():ISignal
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
			return "[LocaleObjectLoader]";
		}
	}
}