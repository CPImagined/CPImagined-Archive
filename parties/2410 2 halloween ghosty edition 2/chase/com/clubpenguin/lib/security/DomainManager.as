package com.clubpenguin.lib.security
{
	import flash.system.Security;
	import com.gskinner.utils.WeakReference;
	import org.osmf.logging.Log;

	public class DomainManager
	{
		// I would use the config system for this but it's not loaded yet.
		private static const ALLOW_LOCAL:Boolean = false;

		private static const __allowedDomains = new WeakReference(new Array());
		
		public static function initDomains():void
		{
			addDomain("play.cpimagined.net");
			
			if (ALLOW_LOCAL)
			{
				addDomain("localhost");
			}
		}

		public static function addDomain(_url:String):void
		{
			if (!isAllowedDomain(_url))
			{
				Log.getLogger("Domains").debug("Adding " + _url + " to allowed domain list!");
				
				Security.allowDomain(_url);
				
				__allowedDomains.get().push(_url);
			}
		}

		public static function isAllowedDomain(_url:String):Boolean
		{
			for each (var domain in __allowedDomains.get())
			{
				if (_url == domain)
				{
					return true;
				}
			}
			return false;
		}
	}
}