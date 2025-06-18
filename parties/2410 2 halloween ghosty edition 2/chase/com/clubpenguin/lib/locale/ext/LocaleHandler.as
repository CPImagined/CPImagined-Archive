package com.clubpenguin.lib.locale.ext
{
	import com.disney.lib.IUniquelyNamable;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	public class LocaleHandler implements ILocaleHandlerExt,IUniquelyNamable
	{
		private static var $_instanceCount:int = -1;
		

		internal static const LOCALE_TEXT_FILETYPE:String = ".xml";

		internal static const LOCALE_ASSET_FILETYPE:String = ".swf";

		internal static const LOCALE_DIRECTORY:String = "lang";
		

		private static const LANG_LOC_EN:String = "en";

		private static const LANG_LOC_PT:String = "pt";

		private static const LANG_LOC_FR:String = "fr";

		private static const LANG_LOC_ES:String = "es";

		private static const LANG_LOC_DE:String = "de";

		private static const LANG_LOC_RU:String = "ru";

		public static const LANG_ID_EN:int = 1;

		public static const LANG_ID_PT:int = 2;

		public static const LANG_ID_FR:int = 3;

		public static const LANG_ID_ES:int = 4;

		public static const LANG_ID_DE:int = 5;

		public static const LANG_ID_RU:int = 6;


		private var __uid:int;

		private var __currentLocale:int;
		
		private var __currentGame:int;

		private var __localeText:Array;

		private var __localeAssets:Array;

		private var __localeAssetNames:Array;

		private var __localeTextNames:Array;

		private var __gameURL:String;

		private var __localeTextLoader:LocaleTextLoader;

		private var __localeAssetLoader:LocaleAssetLoader;

		private var __success:Boolean;

		private var __localeTextReady:Boolean = false;

		private var __localeAssetsReady:Boolean = false;

		private const __signalLoadComplete:Signal = new Signal(Boolean);
		
		public function LocaleHandler(_localeID:int = -1, _localeAssetNames:Array = null, _localeTextNames:Array = null, _gameURL:String = "", _loadCompleteCallback:Function = null)
		{
			super();
		
			this.__uid = ++$_instanceCount;
			this.__gameURL = _gameURL;
			this.__localeAssetNames = new Array();
			this.__localeTextNames = new Array();
			
			if (_localeAssetNames != null)
			{
				this.setLocaleAssetNames(_localeAssetNames);
			}
			
			if (_localeTextNames != null)
			{
				this.setLocaleTextNames(_localeTextNames);
			}
			
			if (_localeID != -1)
			{
				this.setLocaleByID(_localeID);
			}
			
			if (_loadCompleteCallback != null)
			{
				this.load(_loadCompleteCallback);
			}
		}

		public function load(_loadCompleteCallback:Function):void
		{
			this.__localeTextLoader = new LocaleTextLoader();
			this.__localeAssetLoader = new LocaleAssetLoader();
			this.__signalLoadComplete.addOnce(_loadCompleteCallback);
			
			if(this.__currentLocale != -1)
			{
				this.loadLocale();
			}
			else
			{
				Log.getLogger(this.getUniqueName()).warn("Missing a valid localeID (" + this.__currentLocale + ")");
			}
		}

		public function getString(_key:String):String
		{
			if (this.__localeTextReady)
			{
				if (this.__localeText[_key] != null)
				{
					return this.__localeText[_key];
				}
				
				Log.getLogger(this.getUniqueName()).warn("Undefined locale string! id:" + _key + " value:" + this.__localeText[_key]);
				return "[id:" + _key + " " + this.__localeText[_key] + "]";
			}
			
			Log.getLogger(this.getUniqueName()).warn("Locale text not initialized or no strings available!");
			return "[id:" + _key + " not ready]";
		}

		public function getImage(_assetKey:String, _sourceKey:String = "locale"):DisplayObject
		{
			if (this.__localeAssetsReady)
			{
				var asset:DisplayObject;
				
				var localeSource = this.__localeAssets[_sourceKey] as DisplayObject;
				if (localeSource != null)
				{
					var assetDomain = (this.__localeAssets[_sourceKey] as DisplayObject).loaderInfo.applicationDomain;
					var assetClass = assetDomain.getDefinition(_assetKey) as Class;
					try
					{
						asset = new assetClass();
					}
					catch (e:Error)
					{
						
						Log.getLogger(this.getUniqueName()).warn("Undefined locale asset! id:" + _assetKey + " from: " + _sourceKey + " value:" + asset);
						var notFound = new TextField();
						notFound.text = "[IMAGE id:" + _assetKey + " not found]";
						asset = notFound;
					}
				}
				else
				{
					var noSource = new TextField();
					noSource.text = "[IMAGE source:" + _sourceKey + " not found]";
					asset = noSource;
				}
				return asset;
			}
			
			Log.getLogger(this.getUniqueName()).warn("Assets not initialized or no assets available!");
			var notReady = new TextField();
			notReady.text = "[IMAGE id:" + _assetKey + " not ready]";
			return notReady;
		}

		public function loadLocale():void
		{
			Log.getLogger(this.getUniqueName()).debug("Loading locale text with lang id: " + this.__currentLocale);
			
			this.__localeTextReady = false;
			this.__success = true;

			if (this.__localeTextNames.length == 0)
			{
				this.onLocaleTextLoaded(this.__success);
			}
			else
			{
				this.__localeText = new Array();
				this.__localeTextLoader.complete.addOnce(this.onLocaleTextLoaded);
				this.__localeTextLoader.load(this.getLocaleDirectory(),this.__localeTextNames,this.__localeText);
			}
		}

		private function onLocaleTextLoaded(_success:Boolean):void
		{
			if (this.__localeTextNames.length != 0)
			{
				Log.getLogger(this.getUniqueName()).debug("Loading locale text was " + (_success ? "successful!" : "unsuccessful!"));
				
				this.__localeTextReady = true;
			}
			else
			{
				Log.getLogger(this.getUniqueName()).info("Loading locale text was skipped as no text is defined.");
			}
			
			Log.getLogger(this.getUniqueName()).debug("Loading locale assets with lang id: " + this.__currentLocale);

			this.__success = this.__success && _success;

			this.__localeAssetsReady = false;

			if (this.__localeAssetNames.length == 0)
			{
				this.onLocaleAssetsLoaded(this.__success);
			}
			else
			{
				this.__localeAssets = new Array();
				this.__localeAssetLoader.complete.addOnce(this.onLocaleAssetsLoaded);
				this.__localeAssetLoader.load(this.getLocaleDirectory(),this.__localeAssetNames,this.__localeAssets);
			}
		}

		private function onLocaleAssetsLoaded(_success:Boolean):void
		{
			if (this.__localeAssetNames.length != 0)
			{
				Log.getLogger(this.getUniqueName()).debug("Loading locale assets was " + (_success ? "successful!" : "unsuccessful!"));
				
				this.__localeAssetsReady = true;
			}
			else
			{
				Log.getLogger(this.getUniqueName()).info("Loading locale assets was skipped as no assets are defined.");
			}
			
			this.__success = this.__success && _success;
			
			if(!_success)
			{
				Log.getLogger(this.getUniqueName()).warn("One or more specified locale asset file(s) failed to load.  Locale display items may be missing.");
			}
			
			this.__signalLoadComplete.dispatch(this.__success);
		}

		private function getLocaleDirectory():String
		{
			var urlDir:String = urlDir = this.__gameURL.substring(0,this.__gameURL.lastIndexOf("/") + 1);
			return urlDir + (LOCALE_DIRECTORY + "/" + this.getLangName(this.__currentLocale) + "/");
		}

		public function getLangName(_id:int):String
		{
			var localeName:String = null;
			switch (_id)
			{
				case LANG_ID_EN:
					localeName = LANG_LOC_EN;
					break;
				case LANG_ID_ES:
					localeName = LANG_LOC_ES;
					break;
				case LANG_ID_PT:
					localeName = LANG_LOC_PT;
					break;
				case LANG_ID_FR:
					localeName = LANG_LOC_FR;
					break;
				case LANG_ID_DE:
					localeName = LANG_LOC_DE;
					break;
				case LANG_ID_RU:
					localeName = LANG_LOC_RU;
					break;
				default:
					Log.getLogger(this.getUniqueName()).error("Unknown lang id, was: " + _id + ". Defaulting to English.");
					localeName = LANG_LOC_EN;
			}
			return localeName;
		}

		public function getLangID(_name:String):int
		{
			var localeID:int = 0;
			switch (_name)
			{
				case LANG_LOC_EN:
					localeID = LANG_ID_EN;
					break;
				case LANG_LOC_ES:
					localeID = LANG_ID_ES;
					break;
				case LANG_LOC_PT:
					localeID = LANG_ID_PT;
					break;
				case LANG_LOC_FR:
					localeID = LANG_ID_FR;
					break;
				case LANG_LOC_DE:
					localeID = LANG_ID_DE;
					break;
				case LANG_ID_RU:
					localeID = LANG_ID_RU;
					break;
				default:
					Log.getLogger(this.getUniqueName()).error("Unknown lang name, was: " + _name + ". Defaulting to English.");
					localeID = LANG_ID_EN;
			}
			return localeID;
		}

		public function setLocaleByID(_localeID:int):void
		{
			Log.getLogger(this.getUniqueName()).debug("setLocaleByID(" + _localeID + ")");
			
			this.__currentLocale = _localeID;
		}

		public function setLocaleByName(_localeName:String):void
		{
			Log.getLogger(this.getUniqueName()).debug("setLocaleByName(" + _localeName + ")");
			
			this.__currentLocale = this.getLangID(_localeName);
		}

		public function getLocaleID():int
		{
			return this.__currentLocale;
		}

		public function getLocaleName():String
		{
			return this.getLangName(this.__currentLocale);
		}
		
		public function setGameID(_gameID:int):void
		{
			this.__currentGame = _gameID;
		}

		public function setGameURL(_gameURL:String):void
		{
			this.__gameURL = _gameURL;
		}

		public function setLocaleAssetNames(_localeAssetNames:Array):void
		{
			this.__localeAssetNames = _localeAssetNames == null ? [] : _localeAssetNames;
		}

		public function setLocaleTextNames(_localeTextNames:Array):void
		{
			this.__localeTextNames = _localeTextNames == null ? [] : _localeTextNames;
		}

		public function getGameURL():String
		{
			return this.__gameURL;
		}

		public function getLocaleAssetNames():Array
		{
			return this.__localeAssetNames;
		}

		public function getLocaleTextNames():Array
		{
			return this.__localeTextNames;
		}

		public function getSignalLoadComplete():ISignal
		{
			return this.__signalLoadComplete;
		}

		public function getUniqueName():String
		{
			return "LocaleHandler" + this.__uid;
		}

		public function dispose():void
		{
			this.__localeText = null;
			this.__localeAssets = null;
			this.__localeAssetNames = null;
			this.__localeTextNames = null;
			
			this.__localeTextLoader.dispose();
			this.__localeAssetLoader.dispose();
			this.__localeTextLoader = null;
			this.__localeAssetLoader = null;
			
			this.__signalLoadComplete.removeAll();
		}
	}
}