//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.events.EventDispatcher;
    import __AS3__.vec.Vector;
    import flash.text.Font;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.display.LoaderInfo;
    import flash.utils.describeType;
    import __AS3__.vec.*;

    public class FontLibrary extends EventDispatcher 
    {

        private var _allFonts:Vector.<Font>;
        private var lang:String;
        private var fontNamesList:Array;
        private var _loadComplete:Boolean;

        public function FontLibrary(_arg_1:String)
        {
            this.lang = _arg_1;
            this.fontNamesList = new Array();
        }

        public function load(_arg_1:String):void
        {
            var _local_2:Loader = new Loader();
            var _local_3:LoaderContext = new LoaderContext();
            _local_3.applicationDomain = ApplicationDomain.currentDomain;
            _local_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onFontLoadComplete);
            _local_2.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            _local_2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            _local_2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            _local_2.load(new URLRequest(_arg_1), _local_3);
        }

        private function onFontLoadComplete(event:Event):void
        {
            var fontLib:Class;
            var i:int;
            var fontClass:Class;
            var loader:LoaderInfo = (event.target as LoaderInfo);
            loader.removeEventListener(Event.COMPLETE, this.onFontLoadComplete);
            loader.removeEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            try
            {
                fontLib = (LoaderInfo(event.target).applicationDomain.getDefinition((("com.clubpenguin.fonts." + this.lang) + ".FontLibrary")) as Class);
            }
            catch(e:Error)
            {
                throw (new Error((("Could not load FontLibrary for language: '" + lang) + "'.")));
            };
            var description:XMLList = describeType(fontLib)..variable;
            this._loadComplete = true;
            try
            {
                while (i < description.length())
                {
                    fontClass = (fontLib[description[i].@name] as Class);
                    Font.registerFont(fontClass);
                    this.fontNamesList.push(description[i].@name);
                    i = (i + 1);
                };
            }
            catch(error:Error)
            {
                throw (new Error(("Error registering loaded fonts: " + error.message)));
            };
            this._allFonts = Vector.<Font>(Font.enumerateFonts());
            dispatchEvent(event);
        }

        public function get isLoadComplete():Boolean
        {
            return (this._loadComplete);
        }

        public function getFontNamesList():Array
        {
            return (this.fontNamesList);
        }

        public function fontHasGlyphs(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:Boolean;
            var _local_5:Font;
            var _local_4:String = _arg_2.replace(/[\r\n]/g, "");
            for each (_local_5 in this._allFonts)
            {
                if (_local_5.fontName == _arg_1)
                {
                    _local_3 = _local_5.hasGlyphs(_local_4);
                    break;
                };
            };
            return (_local_3);
        }

        public function findUnsupportedGlyphsForFont(_arg_1:String, _arg_2:String):String
        {
            var _local_4:Font;
            var _local_5:int;
            var _local_3:Array = [];
            for each (_local_4 in this._allFonts)
            {
                if (_local_4.fontName == _arg_1)
                {
                    if (_arg_2.length > 0)
                    {
                        _local_5 = 0;
                        while (_local_5 < _arg_2.length)
                        {
                            if ((!(_local_4.hasGlyphs(_arg_2.charAt(_local_5)))))
                            {
                                trace(((("glyph not found: " + _arg_2.charAt(_local_5)) + " unicode: ") + _arg_2.charCodeAt(_local_5)));
                                _local_3.push((((((("[index:" + _local_5) + ", char:") + _arg_2.charAt(_local_5)) + ", charCode:") + _arg_2.charCodeAt(_local_5)) + "]"));
                            };
                            _local_5++;
                        };
                    };
                    break;
                };
            };
            return (_local_3.join(","));
        }

        public function isFontRegistered(_arg_1:String):Boolean
        {
            var _local_2:String;
            for each (_local_2 in this.fontNamesList)
            {
                if (_local_2 == _arg_1)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getFontByName(_arg_1:String):Font
        {
            var _local_2:Font;
            for each (_local_2 in this._allFonts)
            {
                if (_local_2.fontName == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function get allFonts():Vector.<Font>
        {
            if ((!(this._allFonts)))
            {
                this._allFonts = Vector.<Font>(Font.enumerateFonts());
            };
            return (this._allFonts);
        }


    }
}//package com.clubpenguin.tools.localtext.core
