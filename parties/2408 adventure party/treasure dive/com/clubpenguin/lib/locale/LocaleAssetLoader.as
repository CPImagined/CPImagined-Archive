package com.clubpenguin.lib.locale{
    import org.osflash.signals.Signal;
    import com.disney.loader.SWFLoader;
    import com.clubpenguin.lib.locale.LocaleHandler;
    import flash.display.MovieClip;
    import org.osflash.signals.ISignal;
    import com.clubpenguin.lib.locale.*;

    internal class LocaleAssetLoader {

        private const __complete:Signal = new Signal(Boolean);

        private var __localeDir:String;
        private var __assetNames:Array;
        private var __localeAssets:Array;
        private var __currIndex:int;
        private var __swfLoader:SWFLoader;
        private var __success:Boolean;


        public function load(_arg_1:String, _arg_2:Array, _arg_3:Array):void{
            this.__currIndex = -1;
            this.__localeAssets = _arg_3;
            this.__localeDir = _arg_1;
            this.__assetNames = _arg_2;
            this.__success = true;
            this.loadNextAsset();
        }

        private function loadNextAsset():void{
            this.__currIndex++;
            if (this.__currIndex >= this.__assetNames.length){
                this.__swfLoader = null;
                this.__complete.dispatch(this.__success);
            } else {
                try {
                    this.__swfLoader = new SWFLoader(((this.__localeDir + this.__assetNames[this.__currIndex]) + LocaleHandler.LOCALE_ASSET_FILETYPE), this.onSWFLoaded, null);
                } catch(e:Error) {
                    __success = false;
                    loadNextAsset();
                };
            };
        }

        private function onSWFLoaded(_arg_1:MovieClip):void{
            if (_arg_1 != null){
                if (this.__localeAssets[this.__assetNames[this.__currIndex]] == null){
                    this.__localeAssets[this.__assetNames[this.__currIndex]] = _arg_1;
                } else {
                    this.__success = false;
                };
            } else {
                this.__success = false;
            };
            this.loadNextAsset();
        }

        public function get complete():ISignal{
            return (this.__complete);
        }


    }
}//package com.clubpenguin.lib.locale
