package com.clubpenguin.lib.security
{
	import com.clubpenguin.game.HostAccess;
	import flash.display.DisplayObject;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class SecurityHandler implements ISecurityHandler
	{
		public static const ALLOWED_URL:String = "cpimagined.net";

		private static const REQUEST_TYPE_HTTP:String = "http";

		private static const REQUEST_TYPE_HTTPS:String = "https";

		private static const REQUEST_TYPE_FILE:String = "file";
		
		// I would use the config system for this but it's not loaded yet.
		private static const ALLOW_LOCAL:Boolean = false;


		private var __domains:Domains;

		private var __securityCheckSuccess:Signal;

		public function SecurityHandler()
		{
			super();
		
			this.__securityCheckSuccess = new Signal();
			this.__domains = Domains.getDomains();
			
			this.__domains.addDomain("play." + ALLOWED_URL);
			
			if (ALLOW_LOCAL)
			{
				this.__domains.addDomain("localhost");
			}
		}

		public function doSecurityCheck(_content:DisplayObject):void
		{
			var workingURL:String = null;
			var requestType:String = null;
			var serverPath:Array = null;
			
			trace("[SecurityHandler] starting security check...");
			
			workingURL = _content.loaderInfo.url;
			requestType = workingURL.substring(0,workingURL.indexOf(":"));
			
			trace("[SecurityHandler] url request type is: " + requestType);
			try
			{
				if (_content.parent == null)
				{
					trace("[SecurityHandler] content parent is null!");
					this.failSecurityCheck(_content);
				}
				else
				{
					switch (requestType)
					{
						case REQUEST_TYPE_HTTP:
						case REQUEST_TYPE_HTTPS:
							serverPath = workingURL.split("/");
							if (String(serverPath[2]).substr(0 - ALLOWED_URL.length) == ALLOWED_URL)
							{
								trace("[SecurityHandler] security check SUCCESS!");
								this.__securityCheckSuccess.dispatch();
							}
							else
							{
								trace("[SecurityHandler] " + workingURL + " not running in an allowed domain!");
								this.failSecurityCheck(_content);
							}
							break;
						case REQUEST_TYPE_FILE:
							if (ALLOW_LOCAL)
							{
								trace("[SecurityHandler] security check SUCCESS!");
								this.__securityCheckSuccess.dispatch();
							}
							else
							{
								trace("[SecurityHandler] " + workingURL + " not running in an allowed domain!");
								this.failSecurityCheck(_content);
							}
							break;
						default:
							trace("[SecurityHandler] " + workingURL + " unknown request type!");
							this.failSecurityCheck(_content);
					}
				}
			}
			catch (e:Error)
			{
				trace("[SecurityHandler] Error while doing security check!\n" + e.getStackTrace());
			}
		}

		private function failSecurityCheck(_content:DisplayObject):void
		{
			throw "[SecurityHandler] security check FAILED! (" + _content.loaderInfo.url + ")";
		}

		public function getSecurityCheckSuccess():ISignal
		{
			return this.__securityCheckSuccess;
		}
	}
}