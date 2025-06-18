package com.clubpenguin.lib.locale.ext
{
	import com.disney.loader.ext.XMLLoader;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	internal class LocaleTextLoader extends LocaleObjectLoader
	{
		public static const ENTRY_TAG:String = "entry";

		public static const ENTRY_ID_ATR:String = "id";

		public static const ENTRY_VALUE_ATR:String = "value";

		public function LocaleTextLoader()
		{
			super();
		}

		override protected function get locale_obj_filetype():String
		{
			return LocaleHandler.LOCALE_TEXT_FILETYPE;
		}

		override protected function get loader_class():String
		{
			return "com.disney.loader.ext.XMLLoader";
		}

		override protected function handleObjectLoaded(_localeXML:Object):void
		{
			if (_localeXML as XML != null)
			{
				var entries:XMLList = null;
				var id:String = null;
				var value:String = null;
				var entry:XML = null;
				
				Log.getLogger(this.getUniqueName()).debug("Locale text XML loaded!");
				
				entries = _localeXML.child(ENTRY_TAG);
				if (entries != null)
				{
					for each (entry in entries)
					{
						id = entry.attribute(ENTRY_ID_ATR);
						value = entry.attribute(ENTRY_VALUE_ATR);
						if (id != null && value != null)
						{
							if (this.__loadedObjs[id] == null)
							{
								this.__loadedObjs[id] = value;
								
								Log.getLogger(this.getUniqueName()).debug("id:" + id + " value:" + value);
							}
							else
							{
								
								Log.getLogger(this.getUniqueName()).error("Duplicate entry found for id:" + id + " value:" + this.__loadedObjs[id] + " but found:" + value);
								this.__success = false;
							}
						}
						else
						{
							Log.getLogger(this.getUniqueName()).error("Improper entry! id:" + id + " value:" + value);
							this.__success = false;
						}
					}
				}
				else
				{
					Log.getLogger(this.getUniqueName()).error("Loaded XML but could not find any entry tags!");
					this.__success = false;
				}
			}
			else
			{
				Log.getLogger(this.getUniqueName()).error("Loaded XML came back as null, cannot be parsed!");
				this.__success = false;
			}
		}
		
		override public function getUniqueName():String
		{
			return "LocaleTextLoader";
		}
	}
}