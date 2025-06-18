package com.clubpenguin.tools.localtext.core
{
    import flash.utils.*;

    public interface ILocalizedText
    {

        public function ILocalizedText();

        function setLocalText(param1:Dictionary) : void;

        function getTextForToken(param1:String) : String;

    }
}
