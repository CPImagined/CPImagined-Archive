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


        public function load(_localeDir:String, _localeText:Array):void{
            this.__localeDir = _localeDir;
            this.__localeText = _localeText;
            this.__success = true;
            try {
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
            if (_arg_1 != null){
                _local_2 = _arg_1.child(ENTRY_TAG);
                if (_local_2 != null){
                    for each (_local_5 in _local_2) {
                        _local_3 = _local_5.attribute(ENTRY_ID_ATR);
                        _local_4 = _local_5.attribute(ENTRY_VALUE_ATR);
                        if (((!(_local_3 == null)) && (!(_local_4 == null)))){
                            if (this.__localeText[_local_3] == null){
                                this.__localeText[_local_3] = _local_4;
                            } else {
                                this.__success = false;
                            };
                        } else {
                            this.__success = false;
                        };
                    };
                } else {
                    this.__success = false;
                };
            } else {
                this.__success = false;
            };
            this.__loader = null;
            this.__complete.dispatch(this.__success);
        }

        public function get complete():ISignal{
            return (this.__complete);
        }


    }
}//package com.clubpenguin.lib.locale
