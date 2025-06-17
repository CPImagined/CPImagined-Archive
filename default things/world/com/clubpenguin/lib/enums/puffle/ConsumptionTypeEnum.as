//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.puffle
{
    import com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;

    public class ConsumptionTypeEnum extends Enum 
    {

        public static const NONE:ConsumptionTypeEnum = new ConsumptionTypeEnum(CareItemVO.NONE);
        public static const EAT:ConsumptionTypeEnum = new ConsumptionTypeEnum(CareItemVO.EAT);
        public static const BRUSH:ConsumptionTypeEnum = new ConsumptionTypeEnum(CareItemVO.BRUSH);
        public static const BATHE:ConsumptionTypeEnum = new ConsumptionTypeEnum(CareItemVO.BATHE);
        public static const WEAR:ConsumptionTypeEnum = new ConsumptionTypeEnum(CareItemVO.WEAR);
        public static const CONSUMPTION_TYPE_ENUM_LIST:Array = Enum.createList(ConsumptionTypeEnum);

        private var _type:String;

        public function ConsumptionTypeEnum(_arg_1:String)
        {
            this._type = _arg_1;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function toString():String
        {
            return (('[ConsumptionTypeEnum type="' + this._type) + '"]');
        }


    }
}//package com.clubpenguin.lib.enums.puffle
