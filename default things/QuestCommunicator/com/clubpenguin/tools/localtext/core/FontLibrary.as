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
    import flash.display.MovieClip;
    import flash.utils.describeType;
    import __AS3__.vec.*;

    public class FontLibrary extends EventDispatcher 
    {

        private var _allFonts:Vector.<Font>;
        private var lang:String;
        private var fontNamesList:Array;
        private var _loadComplete:Boolean;

        public function FontLibrary(lang:String)
        {
            this.lang = lang;
            this.fontNamesList = new Array();
        }

        public function load(url:String):void
        {
            var fontLoader:Loader = new Loader();
            var loaderContext:LoaderContext = new LoaderContext();
            loaderContext.applicationDomain = ApplicationDomain.currentDomain;
            fontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onFontLoadComplete);
            fontLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            fontLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            fontLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            fontLoader.load(new URLRequest(url), loaderContext);
        }

        private function onFontLoadComplete(event:Event):void
        {
            var loader:LoaderInfo = (event.target as LoaderInfo);
            loader.removeEventListener(Event.COMPLETE, this.onFontLoadComplete);
            loader.removeEventListener(ProgressEvent.PROGRESS, dispatchEvent);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            var fontLibClass:Class = this.validateFontLibClass(LoaderInfo(event.target));
            this.registerFontsFromLibraryClass(fontLibClass);
        }

        public function loadFromEmbeddedSWF(embeddedSWF:MovieClip):void
        {
            var loaderInfo:LoaderInfo = (embeddedSWF.getChildAt(0) as Loader).contentLoaderInfo;
            var fontLibClass:Class = this.validateFontLibClass(loaderInfo);
            this.registerFontsFromLibraryClass(fontLibClass);
        }

        private function validateFontLibClass(loaderInfo:LoaderInfo):Class
        {
            var fontLib:Class;
            try
            {
                fontLib = (loaderInfo.applicationDomain.getDefinition((("com.clubpenguin.fonts." + this.lang) + ".FontLibrary")) as Class);
            }
            catch(e:Error)
            {
                throw (new Error((("Could not load FontLibrary for language: '" + lang) + "'.")));
            };
            return (fontLib);
        }

        private function registerFontsFromLibraryClass(fontLib:Class):void
        {
            var i:int;
            var fontClass:Class;
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
            dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get isLoadComplete():Boolean
        {
            return (this._loadComplete);
        }

        public function getFontNamesList():Array
        {
            return (this.fontNamesList);
        }

        public function fontHasGlyphs(fontAlias:String, text:String):Boolean
        {
            var hasGlyphs:Boolean;
            var font:Font;
            var carriageReturnsRemoved:String = text.replace(/[\r\n]/g, "");
            for each (font in this._allFonts)
            {
                if (font.fontName == fontAlias)
                {
                    hasGlyphs = font.hasGlyphs(carriageReturnsRemoved);
                    break;
                };
            };
            return (hasGlyphs);
        }

        public function findUnsupportedGlyphsForFont(fontAlias:String, text:String):String
        {
            var font:Font;
            var i:int;
            var unsupportedGlyphs:Array = [];
            for each (font in this._allFonts)
            {
                if (font.fontName == fontAlias)
                {
                    if (text.length > 0)
                    {
                        i = 0;
                        while (i < text.length)
                        {
                            if ((!(font.hasGlyphs(text.charAt(i)))))
                            {
                                trace(((("glyph not found: " + text.charAt(i)) + " unicode: ") + text.charCodeAt(i)));
                                unsupportedGlyphs.push((((((("[index:" + i) + ", char:") + text.charAt(i)) + ", charCode:") + text.charCodeAt(i)) + "]"));
                            };
                            i++;
                        };
                    };
                    break;
                };
            };
            return (unsupportedGlyphs.join(","));
        }

        public function isFontRegistered(fontAlias:String):Boolean
        {
            var name:String;
            for each (name in this.fontNamesList)
            {
                if (name == fontAlias)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function getFontByName(fontAlias:String):Font
        {
            var font:Font;
            for each (font in this._allFonts)
            {
                if (font.fontName == fontAlias)
                {
                    return (font);
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
