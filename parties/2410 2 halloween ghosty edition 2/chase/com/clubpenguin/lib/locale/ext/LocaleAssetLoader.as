package com.clubpenguin.lib.locale.ext
{
	import com.disney.loader.ext.SWFLoader;

	internal class LocaleAssetLoader extends LocaleObjectLoader
	{
		public function LocaleAssetLoader()
		{
			super();
		}
		
		override protected function get locale_obj_filetype():String
		{
			return LocaleHandler.LOCALE_ASSET_FILETYPE;
		}
		
		override protected function get loader_class():String
		{
			return "com.disney.loader.ext.SWFLoader";
		}
		
		override public function getUniqueName():String
		{
			return "LocaleAssetLoader";
		}
	}
}