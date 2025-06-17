package com.clubpenguin.tools.localtext.core
{
    import __AS3__.vec.*;
    import flash.text.*;

    public class LocalTextProxy extends Object
    {
        private static const _localTextFields:Array = [];
        private static const _fontLibraryDependants:Array = [];
        private static var _localText:ILocalText;
        private static var compileTimeEnumeratedFonts:Vector.<Font> = LocalTextProxy.Vector.<Font>(Font.enumerateFonts());

        public function LocalTextProxy()
        {
            return;
        }// end function

        public static function queueLocalTextField(param1:ILocalTextField) : void
        {
            if (!_localText)
            {
                _localTextFields.push(param1);
            }
            else
            {
                _localText.addLocalTF(param1);
            }
            return;
        }// end function

        public static function queueFontLibraryDependant(param1:IFontLibraryDependant) : void
        {
            if (_localText && _localText.libraryInitialized)
            {
                param1.onFontLibraryLoaded();
            }
            else if (_localText)
            {
                _localText.registerFontLibraryDependant(param1);
            }
            else
            {
                _fontLibraryDependants.push(param1);
            }
            return;
        }// end function

        public static function get initialized() : Boolean
        {
            return _localText != null && _localText.libraryInitialized;
        }// end function

        public static function get localText() : ILocalText
        {
            if (!_localText)
            {
                throw new Error("An ILocalText implementation has not been set.");
            }
            return _localText;
        }// end function

        public static function set localText(param1:ILocalText) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _localText = param1;
            for each (_loc_2 in _localTextFields)
            {
                
                _localText.addLocalTF(_loc_2);
            }
            _loc_5.length = 0;
            for each (_loc_3 in _fontLibraryDependants)
            {
                
                if (_localText.libraryInitialized)
                {
                    _loc_3.onFontLibraryLoaded();
                    continue;
                }
                _localText.registerFontLibraryDependant(_loc_3);
            }
            _loc_5.length = 0;
            return;
        }// end function

        public static function get allFonts() : Vector.<Font>
        {
            if (!_localText)
            {
                return compileTimeEnumeratedFonts;
            }
            return _localText.fontLibrary.allFonts;
        }// end function

    }
}
