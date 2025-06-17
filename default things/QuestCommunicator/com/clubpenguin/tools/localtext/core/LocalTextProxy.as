//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import __AS3__.vec.Vector;
    import flash.text.Font;
    import __AS3__.vec.*;

    public class LocalTextProxy 
    {

        private static const _localTextFields:Array = [];
        private static const _fontLibraryDependants:Array = [];
        private static var _localText:ILocalText;
        private static var compileTimeEnumeratedFonts:Vector.<Font> = Vector.<Font>(Font.enumerateFonts());


        public static function queueLocalTextField(localTF:ILocalTextField):void
        {
            if ((!(_localText)))
            {
                _localTextFields.push(localTF);
            }
            else
            {
                _localText.addLocalTF(localTF);
            };
        }

        public static function queueFontLibraryDependant(dependant:IFontLibraryDependant):void
        {
            if (((_localText) && (_localText.libraryInitialized)))
            {
                dependant.onFontLibraryLoaded();
            }
            else
            {
                if (_localText)
                {
                    _localText.registerFontLibraryDependant(dependant);
                }
                else
                {
                    _fontLibraryDependants.push(dependant);
                };
            };
        }

        public static function get initialized():Boolean
        {
            return ((!(_localText == null)) && (_localText.libraryInitialized));
        }

        public static function get localText():ILocalText
        {
            if ((!(_localText)))
            {
                throw (new Error("An ILocalText implementation has not been set."));
            };
            return (_localText);
        }

        public static function set localText(value:ILocalText):void
        {
            var localTF:LocalTextField;
            var fontLibDependant:IFontLibraryDependant;
            _localText = value;
            for each (localTF in _localTextFields)
            {
                _localText.addLocalTF(localTF);
            };
            _localTextFields.length = 0;
            for each (fontLibDependant in _fontLibraryDependants)
            {
                if (_localText.libraryInitialized)
                {
                    fontLibDependant.onFontLibraryLoaded();
                }
                else
                {
                    _localText.registerFontLibraryDependant(fontLibDependant);
                };
            };
            _fontLibraryDependants.length = 0;
        }

        public static function get allFonts():Vector.<Font>
        {
            if ((!(_localText)))
            {
                return (compileTimeEnumeratedFonts);
            };
            return (_localText.fontLibrary.allFonts);
        }


    }
}//package com.clubpenguin.tools.localtext.core
