package com.clubpenguin.lib.security
{
	import flash.system.Security;

	internal class Domains
	{
		private static var __instance:Domains = null;

		private var __allowedDomains:Array;

		public function Domains()
		{
			super();
		
			__instance = this;
			
			this.__allowedDomains = new Array();
		}

		public static function getDomains():Domains
		{
			if (__instance != null)
			{
				return __instance;
			}
			return new Domains();
		}

		public function addDomain(_url:String):void
		{
			if (!this.isAllowedDomain(_url))
			{
				trace("[Domains] adding " + _url + " to allowed domain list!");
				Security.allowDomain(_url);
				this.__allowedDomains.push(_url);
			}
		}

		public function isAllowedDomain(_url:String):Boolean
		{
			for each (var domain in this.__allowedDomains)
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