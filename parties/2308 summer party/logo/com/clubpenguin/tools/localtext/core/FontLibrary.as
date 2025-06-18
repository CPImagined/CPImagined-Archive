package com.clubpenguin.tools.localtext.core
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class FontLibrary extends EventDispatcher
    {
        private var _allFonts:Vector.<Font>;
        private var lang:String;
        private var fontNamesList:Array;
        private var _loadComplete:Boolean;

        public function FontLibrary(param1:String)
        {
            this.lang = param1;
            this.fontNamesList = new Array();
            return;
        }// end function

        public function load(param1:String) : void
        {
            var _loc_2:* = new Loader();
            var _loc_3:* = new LoaderContext();
            _loc_3.applicationDomain = ApplicationDomain.currentDomain;
            _loc_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onFontLoadComplete);
            _loc_2.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            _loc_2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            _loc_2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            _loc_2.load(new URLRequest(param1), _loc_3);
            return;
        }// end function

        private function onFontLoadComplete(event:Event) : void
        {
            var fontLib:Class;
            var i:int;
            var fontClass:Class;
            var event:* = event;
            var loader:* = event.target as LoaderInfo;
            loader.removeEventListener(Event.COMPLETE, this.onFontLoadComplete);
            loader.removeEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            try
            {
                fontLib = LoaderInfo(event.target).applicationDomain.getDefinition("com.clubpenguin.fonts." + this.lang + ".FontLibrary") as Class;
            }
            catch (e:Error)
            {
                throw new Error("Could not load FontLibrary for language: \'" + lang + "\'.");
            }
            var description:* = describeType(fontLib)..variable;
            this._loadComplete = true;
            try
            {
                while (i < description.length())
                {
                    
                    fontClass = fontLib[description[i].@name] as Class;
                    Font.registerFont(fontClass);
                    this.fontNamesList.push(description[i].@name);
                    i = (i + 1);
                }
            }
            catch (error:Error)
            {
                throw new Error("Error registering loaded fonts: " + error.message);
            }
            this._allFonts = this.Vector.<Font>(Font.enumerateFonts());
            dispatchEvent(event);
            return;
        }// end function

        public function get isLoadComplete() : Boolean
        {
            return this._loadComplete;
        }// end function

        public function getFontNamesList() : Array
        {
            return this.fontNamesList;
        }// end function

        public function fontHasGlyphs(param1:String, param2:String) : Boolean
        {
            var _loc_3:* = false;
            var _loc_5:* = null;
            var _loc_4:* = param2.replace(/[
]/g, "");
            for each (_loc_5 in this._allFonts)
            {
                
                if (_loc_5.fontName == param1)
                {
                    _loc_3 = _loc_5.hasGlyphs(_loc_4);
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function findUnsupportedGlyphsForFont(param1:String, param2:String) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_3:* = [];
            for each (_loc_4 in this._allFonts)
            {
                
                if (_loc_4.fontName == param1)
                {
                    if (param2.length > 0)
                    {
                        _loc_5 = 0;
                        while (_loc_5 < param2.length)
                        {
                            
                            if (!_loc_4.hasGlyphs(param2.charAt(_loc_5)))
                            {
                                trace("glyph not found: " + param2.charAt(_loc_5) + " unicode: " + param2.charCodeAt(_loc_5));
                                _loc_3.push("[index:" + _loc_5 + ", char:" + param2.charAt(_loc_5) + ", charCode:" + param2.charCodeAt(_loc_5) + "]");
                            }
                            _loc_5++;
                        }
                    }
                    break;
                }
            }
            return _loc_3.join(",");
        }// end function

        public function isFontRegistered(param1:String) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.fontNamesList)
            {
                
                if (_loc_2 == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getFontByName(param1:String) : Font
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._allFonts)
            {
                
                if (_loc_2.fontName == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get allFonts() : Vector.<Font>
        {
            if (!this._allFonts)
            {
                this._allFonts = this.Vector.<Font>(Font.enumerateFonts());
            }
            return this._allFonts;
        }// end function

    }
}
