//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.managers.localization
{
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.core.ILocalizedText;

    public interface ILocalizationManager 
    {

        function getLocalizedString(_arg_1:String, ... _args):String;
        function getPath(_arg_1:String):String;
        function localizeField(_arg_1:TextField, ... _args):void;
        function getGameStrings():ILocalizedText;
        function replaceTags(_arg_1:String, ... _args):String;

    }
}//package com.clubpenguin.lib.managers.localization
