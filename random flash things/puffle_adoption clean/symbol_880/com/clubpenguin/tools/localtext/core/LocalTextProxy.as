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


        public static function queueLocalTextField(_arg_1:ILocalTextField):void
        {
            if ((!(_localText)))
            {
                _localTextFields.push(_arg_1);
            }
            else
            {
                _localText.addLocalTF(_arg_1);
            };
        }

        public static function queueFontLibraryDependant(_arg_1:IFontLibraryDependant):void
        {
            if (((_localText) && (_localText.libraryInitialized)))
            {
                _arg_1.onFontLibraryLoaded();
            }
            else
            {
                if (_localText)
                {
                    _localText.registerFontLibraryDependant(_arg_1);
                }
                else
                {
                    _fontLibraryDependants.push(_arg_1);
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

        public static function set localText(_arg_1:ILocalText):void
        {
            var _local_2:LocalTextField;
            var _local_3:IFontLibraryDependant;
            _localText = _arg_1;
            for each (_local_2 in _localTextFields)
            {
                _localText.addLocalTF(_local_2);
            };
            _localTextFields.length = 0;
            for each (_local_3 in _fontLibraryDependants)
            {
                if (_localText.libraryInitialized)
                {
                    _local_3.onFontLibraryLoaded();
                }
                else
                {
                    _localText.registerFontLibraryDependant(_local_3);
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
