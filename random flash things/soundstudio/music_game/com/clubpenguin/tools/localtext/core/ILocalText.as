//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.events.IEventDispatcher;

    public interface ILocalText extends IEventDispatcher 
    {

        function registerFontLibraryDependant(_arg_1:IFontLibraryDependant):void;
        function get libraryInitialized():Boolean;
        function addLocalTF(_arg_1:ILocalTextField):void;
        function setText(_arg_1:ILocalTextField, _arg_2:String):void;
        function setLocalizedText(_arg_1:ILocalizedText):void;
        function loadFontLibrary(_arg_1:String):void;
        function get fontLibrary():FontLibrary;

    }
}//package com.clubpenguin.tools.localtext.core
