package com.clubpenguin.lib.locale{
    import org.osflash.signals.Signal;
    import com.disney.loader.XMLLoader;
    import com.clubpenguin.lib.locale.LocaleHandler;
    import org.osflash.signals.ISignal;
    import com.clubpenguin.lib.locale.*;

    internal class LocaleTextLoader {

        public static const ENTRY_TAG:String = "entry";
        public static const ENTRY_ID_ATR:String = "id";
        public static const ENTRY_VALUE_ATR:String = "value";

        private const __complete:Signal = new Signal(Boolean);

        private var __success:Boolean;
        private var __localeDir:String;
        private var __localeText:Array;
        private var __loader:XMLLoader;


        public function load(_arg_1:String, _arg_2:Array):void{
            var _localeDir:String = _arg_1;
            var _localeText:Array = _arg_2;
            this.__localeDir = _localeDir;
            this.__localeText = _localeText;
            this.__success = true;
            try {
                trace(((("[LocaleTextLoader] Loading locale text from:" + this.__localeDir) + LocaleHandler.LOCALE_TEXT_FILENAME) + LocaleHandler.LOCALE_TEXT_FILETYPE));
                this.__loader = new XMLLoader(((this.__localeDir.replace("media1", "media2") + LocaleHandler.LOCALE_TEXT_FILENAME) + LocaleHandler.LOCALE_TEXT_FILETYPE), this.onLoadComplete);
            } catch(e:Error) {
                __success = false;
                __complete.dispatch(__success);
            };
        }

        private function onLoadComplete(_arg_1:XML):void{
            var _local_2:XMLList;
            var _local_3:String;
            var _local_4:String;
            var _local_5:XML;
            trace("[LocaleTextLoader] Locale text XML loaded!");
            if (_arg_1 != null){
                _local_2 = _arg_1.child(ENTRY_TAG);
                if (_local_2 != null){
                    for each (_local_5 in _local_2) {
                        _local_3 = _local_5.attribute(ENTRY_ID_ATR);
                        _local_4 = _local_5.attribute(ENTRY_VALUE_ATR);
                        if (((!(_local_3 == null)) && (!(_local_4 == null)))){
                            if (this.__localeText[_local_3] == null){
                                this.__localeText[_local_3] = _local_4;
                                trace(((("[LocaleTextLoader] id:" + _local_3) + " value:") + _local_4));
                            } else {
                                trace(((((("[LocaleTextLoader] ERROR duplicate entry found for id:" + _local_3) + " value:") + this.__localeText[_local_3]) + " but found:") + _local_4));
                                this.__success = false;
                            };
                        } else {
                            trace(((("[LocaleTextLoader] ERROR improper entry! id:" + _local_3) + " value:") + _local_4));
                            this.__success = false;
                        };
                    };
                } else {
                    trace("[LocaleTextLoader] ERROR loaded XML could not find any entry tags!");
                    this.__success = false;
                };
            } else {
                trace("[LocaleTextLoader] ERROR loaded XML came back as null, cannot be parsed!");
                this.__success = false;
            };
            this.__loader = null;
            trace(("[LocaleTextLoader] Locale text loaded " + ((this.__success) ? "successfully!" : "unsuccessfully!")));
            this.__complete.dispatch(this.__success);
        }

        public function get complete():ISignal{
            return (this.__complete);
        }


    }
}//package com.clubpenguin.lib.locale
