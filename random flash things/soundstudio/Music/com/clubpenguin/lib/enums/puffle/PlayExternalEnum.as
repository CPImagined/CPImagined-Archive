//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.puffle
{
    import com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;

    public class PlayExternalEnum extends Enum 
    {

        public static const NONE:PlayExternalEnum = new PlayExternalEnum(CareItemVO.NONE);
        public static const SLEEP:PlayExternalEnum = new PlayExternalEnum(CareItemVO.SLEEP);
        public static const LEASH:PlayExternalEnum = new PlayExternalEnum(CareItemVO.LEASH);
        public static const BUBBLEGUM:PlayExternalEnum = new PlayExternalEnum(CareItemVO.BUBBLEGUM);
        public static const PLAY:PlayExternalEnum = new PlayExternalEnum(CareItemVO.PLAY);
        public static const SUPERPLAY:PlayExternalEnum = new PlayExternalEnum(CareItemVO.SUPERPLAY);
        public static const PLAY_EXTERNAL_ENUM_LIST:Array = Enum.createList(PlayExternalEnum);

        private var _type:String;

        public function PlayExternalEnum(_arg_1:String)
        {
            this._type = _arg_1;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function toString():String
        {
            return (('[PlayExternalEnum type="' + this._type) + '"]');
        }


    }
}//package com.clubpenguin.lib.enums.puffle
