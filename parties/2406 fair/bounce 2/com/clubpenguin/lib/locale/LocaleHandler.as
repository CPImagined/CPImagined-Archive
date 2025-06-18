package com.clubpenguin.lib.locale{
    import org.osflash.signals.Signal;
    import flash.display.DisplayObject;
    import flash.system.ApplicationDomain;
    import flash.text.TextField;
    import org.osflash.signals.ISignal;

    public class LocaleHandler implements ILocaleHandler {

        private static var $_instanceCount:int = -1;
        internal static const LOCALE_TEXT_FILENAME:String = "locale";
        internal static const LOCALE_TEXT_FILETYPE:String = ".xml";
        internal static const LOCALE_ASSET_FILETYPE:String = ".swf";
        internal static const LOCALE_DIRECTORY:String = "lang";
        private static const LANG_LOC_EN:String = "en";
        private static const LANG_LOC_PT:String = "pt";
        private static const LANG_LOC_FR:String = "fr";
        private static const LANG_LOC_ES:String = "es";
        private static const LANG_LOC_DE:String = "de";
        private static const LANG_LOC_RU:String = "ru";
        public static const LANG_ID_EN:Number = 1;
        public static const LANG_ID_PT:Number = 2;
        public static const LANG_ID_FR:Number = 3;
        public static const LANG_ID_ES:Number = 4;
        public static const LANG_ID_DE:Number = 5;
        public static const LANG_ID_RU:Number = 6;

        private const __signalLoadComplete:Signal = new Signal(Boolean);

        private var __uid:int;
        private var __currentLocale:int;
        private var __currentGame:int;
        private var __localeText:Array;
        private var __localeAssets:Array;
        private var __localeAssetNames:Array;
        private var __gameURL:String;
        private var __localeTextLoader:LocaleTextLoader;
        private var __localeAssetLoader:LocaleAssetLoader;
        private var __success:Boolean;
        private var __localeTextReady:Boolean = false;
        private var __localeAssetsReady:Boolean = false;

        public function LocaleHandler(_arg_1:int=-1, _arg_2:int=-1, _arg_3:Array=null, _arg_4:String="", _arg_5:Function=null):void{
            this.__uid = ++$_instanceCount;
            this.__gameURL = _arg_4;
            this.__localeAssetNames = new Array();
            if (_arg_1 != -1){
                this.setLocaleAssetNames(_arg_3);
                this.setGameID(_arg_1);
                this.setLocaleByID(_arg_2);
            };
            if (_arg_5 != null){
                this.load(_arg_5);
            };
        }

        public function load(_arg_1:Function):void{
            this.__localeTextLoader = new LocaleTextLoader();
            this.__localeAssetLoader = new LocaleAssetLoader();
            this.__signalLoadComplete.addOnce(_arg_1);
            if (((!(this.__currentGame == -1)) && (!(this.__currentLocale == -1)))){
                this.loadLocale();
            } else {
                trace((((("Missing either a valid gameID(" + this.__currentGame) + ") or a valid localeID(") + this.__currentLocale) + ")"));
            };
        }

        public function getString(_arg_1:String):String{
            if (this.__localeTextReady){
                if (this.__localeText[_arg_1] != null){
                    return (this.__localeText[_arg_1]);
                };
                trace(((((this.getUniqueName() + "Undefined locale string! id:") + _arg_1) + " value:") + this.__localeText[_arg_1]));
                return (((("[id:" + _arg_1) + " ") + this.__localeText[_arg_1]) + "]");
            };
            trace((this.getUniqueName() + "Locale Text not initialized or no Strings available!"));
            return (("[id:" + _arg_1) + " not ready]");
        }

        public function getImage(_arg_1:String, _arg_2:String="locale"):DisplayObject{
            var asset:DisplayObject;
            var assetClass:Class;
            var assetDomain:ApplicationDomain;
            var localeSource:DisplayObject;
            var notFound:TextField;
            var noSource:TextField;
            var _assetKey:String = _arg_1;
            var _sourceKey:String = _arg_2;
            if (this.__localeAssetsReady){
                localeSource = (this.__localeAssets[_sourceKey] as DisplayObject);
                if (localeSource != null){
                    assetDomain = (this.__localeAssets[_sourceKey] as DisplayObject).loaderInfo.applicationDomain;
                    assetClass = (assetDomain.getDefinition(_assetKey) as Class);
                    try {
                        asset = new (assetClass)();
                    } catch(e:Error) {
                        trace(((((((getUniqueName() + "Undefined locale asset! id:") + _assetKey) + " from: ") + _sourceKey) + " value:") + asset));
                        notFound = new TextField();
                        notFound.text = (("[IMAGE id:" + _assetKey) + " not found]");
                        asset = notFound;
                    };
                } else {
                    noSource = new TextField();
                    noSource.text = (("[IMAGE source:" + _sourceKey) + " not found]");
                    asset = noSource;
                };
                return (asset);
            };
            trace((this.getUniqueName() + "Assets not initialized or no Assets available"));
            var notReady:TextField = new TextField();
            notReady.text = (("[IMAGE id:" + _assetKey) + " not ready]");
            return (notReady);
        }

        public function loadLocale():void{
            trace(((((this.getUniqueName() + " Loading locale text with lang id:") + this.__currentLocale) + " game id:") + this.__currentGame));
            this.__localeTextReady = false;
            this.__success = true;
            this.__localeText = new Array();
            this.__localeTextLoader.complete.addOnce(this.onLocaleTextLoaded);
            this.__localeTextLoader.load(this.getLocaleDirectory(), this.__localeText);
        }

        private function onLocaleTextLoaded(_arg_1:Boolean):void{
            trace(((this.getUniqueName() + " Loading locale text was ") + ((_arg_1) ? "successful!" : "unsuccessful!")));
            this.__localeTextReady = true;
            this.__success = ((Boolean(this.__success)) && (Boolean(_arg_1)));
            trace(((((this.getUniqueName() + " Loading locale assets with lang id:") + this.__currentLocale) + " game id:") + this.__currentGame));
            this.__localeAssetsReady = false;
            this.__localeAssets = new Array();
            this.__localeAssetLoader.complete.addOnce(this.onLocaleAssetsLoaded);
            this.__localeAssetLoader.load(this.getLocaleDirectory(), this.__localeAssetNames, this.__localeAssets);
        }

        private function onLocaleAssetsLoaded(_arg_1:Boolean):void{
            trace(((this.getUniqueName() + " Loading locale assets was ") + ((_arg_1) ? "successful!" : "unsuccessful!")));
            this.__localeAssetsReady = true;
            if (!_arg_1){
                trace("[LocaleHandler] WARNING! One or more specified locale asset file(s) failed to load.  Locale display items may be missing.");
            };
            this.__signalLoadComplete.dispatch(this.__success);
        }

        private function getLocaleDirectory():String{
            var _local_1:String = (_local_1 = this.__gameURL.substring(0, (this.__gameURL.lastIndexOf("/") + 1)));
            return (_local_1 + (((LOCALE_DIRECTORY + "/") + this.getLangName(this.__currentLocale)) + "/"));
        }

        public function getLangName(_arg_1:int):String{
            var _local_2:String;
            switch (_arg_1){
                case LANG_ID_EN:
                    _local_2 = LANG_LOC_EN;
                    break;
                case LANG_ID_ES:
                    _local_2 = LANG_LOC_ES;
                    break;
                case LANG_ID_PT:
                    _local_2 = LANG_LOC_PT;
                    break;
                case LANG_ID_FR:
                    _local_2 = LANG_LOC_FR;
                    break;
                case LANG_ID_DE:
                    _local_2 = LANG_LOC_DE;
                    break;
                case LANG_ID_RU:
                    _local_2 = LANG_LOC_RU;
                    break;
                default:
                    trace((((this.getUniqueName() + " ERROR unknown lang id, was: ") + _arg_1) + " defaulting to english."));
                    _local_2 = LANG_LOC_EN;
            };
            return (_local_2);
        }

        public function getLangID(_arg_1:String):int{
            var _local_2:int;
            switch (_arg_1){
                case LANG_LOC_EN:
                    _local_2 = int(LANG_ID_EN);
                    break;
                case LANG_LOC_ES:
                    _local_2 = int(LANG_ID_ES);
                    break;
                case LANG_LOC_PT:
                    _local_2 = int(LANG_ID_PT);
                    break;
                case LANG_LOC_FR:
                    _local_2 = int(LANG_ID_FR);
                    break;
                case LANG_LOC_DE:
                    _local_2 = int(LANG_ID_DE);
                    break;
                case LANG_LOC_RU:
                    _local_2 = int(LANG_ID_RU);
                    break;
                default:
                    trace((((this.getUniqueName() + " ERROR unknown lang name, was: ") + _arg_1) + " defaulting to english."));
                    _local_2 = int(LANG_ID_EN);
            };
            return (_local_2);
        }

        public function setLocaleByID(_arg_1:int):void{
            trace((("[LocaleHandler] setLocaleByID(" + _arg_1) + ")"));
            this.__currentLocale = _arg_1;
        }

        public function setLocaleByName(_arg_1:String):void{
            trace((("[LocaleHandler] setLocaleByName(" + _arg_1) + ")"));
            this.__currentLocale = this.getLangID(_arg_1);
        }

        public function getLocaleID():int{
            return (this.__currentLocale);
        }

        public function getLocaleName():String{
            return (this.getLangName(this.__currentLocale));
        }

        public function setGameID(_arg_1:int):void{
            this.__currentGame = _arg_1;
        }

        public function setGameURL(_arg_1:String):void{
            this.__gameURL = _arg_1;
        }

        public function setLocaleAssetNames(_arg_1:Array):void{
            this.__localeAssetNames = ((_arg_1 == null) ? [] : _arg_1);
        }

        public function getGameURL():String{
            return (this.__gameURL);
        }

        public function getLocaleAssetNames():Array{
            return (this.__localeAssetNames);
        }

        public function getSignalLoadComplete():ISignal{
            return (this.__signalLoadComplete);
        }

        public function getUniqueName():String{
            return (("[LocaleHandler" + this.__uid) + "]");
        }

        public function dispose():void{
            this.__localeTextLoader = null;
            this.__localeAssetLoader = null;
            this.__signalLoadComplete.removeAll();
        }


    }
}//package com.clubpenguin.lib.locale
