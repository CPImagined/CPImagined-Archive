//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo
{
    import com.clubpenguin.tools.localtext.core.ILocalizedText;
    import flash.utils.Dictionary;

    public class GameStringsVO implements ILocalizedText 
    {

        private var data:Dictionary;


        public function getTextForToken(token:String):String
        {
            if (token != null)
            {
                return (this.data[token]);
            };
            return (null);
        }

        public function setLocalText(data:Dictionary):void
        {
            this.data = data;
        }


    }
}//package com.clubpenguin.lib.vo
