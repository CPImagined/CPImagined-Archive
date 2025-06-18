//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import com.clubpenguin.tools.localtext.core.commands.SetupLTFOnFontLoadCMD;
    import com.clubpenguin.tools.localtext.core.commands.SetLTFGroupFontSizeCMD;
    import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
    import com.clubpenguin.tools.localtext.core.commands.UpdateLangSpecificPropsCMD;

    public class LocalText extends EventDispatcher implements ILocalText 
    {

        private var langEnum:LanguageEnum;
        private var debugMode:Boolean;
        private var _fontLibrary:FontLibrary;
        private var localizedText:ILocalizedText;
        private var localTextFieldGroupCollection:LocalTextFieldGroupCollection;
        private var localTFList:Array = new Array();
        private var fontLibraryDependants:Array = [];
        private var _translateTokens:Boolean = true;


        public function init(langEnum:LanguageEnum, debugMode:Boolean=true):void
        {
            this.langEnum = langEnum;
            this.debugMode = debugMode;
            this._fontLibrary = new FontLibrary(langEnum.lang);
            this.localTextFieldGroupCollection = new LocalTextFieldGroupCollection(this);
        }

        public function setLocalizedText(localizedText:ILocalizedText):void
        {
            this.localizedText = localizedText;
        }

        public function registerFontLibraryDependant(fontLibDependant:IFontLibraryDependant):void
        {
            if (this.fontLibraryDependants.indexOf(fontLibDependant) >= 0)
            {
                return;
            };
            this.fontLibraryDependants.push(fontLibDependant);
        }

        public function get libraryInitialized():Boolean
        {
            return (this._fontLibrary.isLoadComplete);
        }

        public function getFontLibrary():FontLibrary
        {
            return (this._fontLibrary);
        }

        public function loadFontLibrary(url:String):void
        {
            this._fontLibrary.load(url);
            this._fontLibrary.addEventListener(Event.COMPLETE, this.onFontLoadComplete);
            this._fontLibrary.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
        }

        public function addLocalTF(localTF:ILocalTextField):void
        {
            localTF.textBounds.visible = this.debugMode;
            localTF.addEventListener(Event.ENTER_FRAME, this.onLocalTFEnterFrame);
        }

        protected function onLocalTFEnterFrame(event:Event):void
        {
            var localTF:LocalTextField = (event.target as LocalTextField);
            localTF.removeEventListener(Event.ENTER_FRAME, this.onLocalTFEnterFrame);
            this.localTextFieldGroupCollection.addLocalTextField((localTF as LocalTextField));
            if (this._fontLibrary != null)
            {
                if (this._fontLibrary.isLoadComplete)
                {
                    new SetupLTFOnFontLoadCMD(localTF, this.localizedText, this.debugMode, this.localTextFieldGroupCollection, this._fontLibrary, this.langEnum, this.onLocalTFSetupComplete, this._translateTokens).execute();
                    if (localTF.isInGroup)
                    {
                        new SetLTFGroupFontSizeCMD(this.localTextFieldGroupCollection, localTF).execute();
                    };
                }
                else
                {
                    this.localTFList.push(localTF);
                };
            }
            else
            {
                this.localTFList.push(localTF);
            };
        }

        protected function onFontLoadComplete(event:Event):void
        {
            this._fontLibrary.removeEventListener(Event.COMPLETE, this.onFontLoadComplete);
            this._fontLibrary.removeEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            this.updateDependants();
            dispatchEvent(new FontLibraryEvent(FontLibraryEvent.LOAD_COMPLETE));
        }

        protected function updateDependants():void
        {
            var fontLibDependant:IFontLibraryDependant;
            var i:int = (this.fontLibraryDependants.length - 1);
            while (i >= 0)
            {
                fontLibDependant = (this.fontLibraryDependants[i] as IFontLibraryDependant);
                fontLibDependant.onFontLibraryLoaded();
                i--;
            };
            this.fontLibraryDependants.length = 0;
            this.processLocalTFList();
        }

        protected function processLocalTFList():void
        {
            var localTF:LocalTextField;
            if (((this._fontLibrary.isLoadComplete) && (!(this.localizedText == null))))
            {
                for each (localTF in this.localTFList)
                {
                    new SetupLTFOnFontLoadCMD(localTF, this.localizedText, this.debugMode, this.localTextFieldGroupCollection, this._fontLibrary, this.langEnum, this.onLocalTFSetupComplete, this._translateTokens).execute();
                    if (localTF.isInGroup)
                    {
                        new SetLTFGroupFontSizeCMD(this.localTextFieldGroupCollection, localTF).execute();
                    };
                };
                this.localTFList = [];
            };
        }

        public function setText(localTF:ILocalTextField, text:String):void
        {
            localTF.text = text;
            new UpdateLangSpecificPropsCMD((localTF as LocalTextField), this.langEnum, this.onLocalTFSetupComplete).execute();
            if (this.localTextFieldGroupCollection.isLTFMemberOfRegisteredGroup(localTF))
            {
                new SetLTFGroupFontSizeCMD(this.localTextFieldGroupCollection, (localTF as LocalTextField)).execute();
            };
        }

        public function get fontLibrary():FontLibrary
        {
            return (this._fontLibrary);
        }

        public function set fontLibrary(value:FontLibrary):void
        {
            this._fontLibrary = value;
            this.updateDependants();
            dispatchEvent(new FontLibraryEvent(FontLibraryEvent.LOAD_COMPLETE));
        }

        private function onLocalTFSetupComplete():void
        {
        }

        public function get translateTokens():Boolean
        {
            return (this._translateTokens);
        }

        public function set translateTokens(translateTokens:Boolean):void
        {
            this._translateTokens = translateTokens;
        }


    }
}//package com.clubpenguin.tools.localtext.core
