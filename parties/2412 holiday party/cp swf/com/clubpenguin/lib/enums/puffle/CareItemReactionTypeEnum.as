//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.puffle
{
    import com.clubpenguin.lib.enums.Enum;

    public class CareItemReactionTypeEnum extends Enum 
    {

        public static const DISLIKES:CareItemReactionTypeEnum = new CareItemReactionTypeEnum("notwant");
        public static const NEUTRAL:CareItemReactionTypeEnum = new CareItemReactionTypeEnum("neutral");
        public static const LIKES:CareItemReactionTypeEnum = new CareItemReactionTypeEnum("excited");
        public static const FAVOURITE:CareItemReactionTypeEnum = new CareItemReactionTypeEnum("favourite");

        private var _type:String;

        public function CareItemReactionTypeEnum(_arg_1:String)
        {
            this._type = _arg_1;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function toString():String
        {
            return (('[CareItemReactionTypeEnum type="' + this._type) + '"]');
        }


    }
}//package com.clubpenguin.lib.enums.puffle
