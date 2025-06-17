//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.puffle
{
    import com.clubpenguin.lib.vo.IVO;

    public class LowStatVO implements IVO 
    {

        private var __type:String;
        private var __statNum:int;


        public function set type(_type:String):void
        {
            this.__type = _type;
        }

        public function set statNum(_statNum:int):void
        {
            this.__statNum = _statNum;
        }

        public function get type():String
        {
            return (this.__type);
        }

        public function get statNum():int
        {
            return (this.__statNum);
        }

        public function destroy():void
        {
        }

        public function get id():int
        {
            return (-1);
        }

        public function update(vo:IVO):void
        {
        }

        public function equals(vo:IVO):Boolean
        {
            return (false);
        }

        public function toString():String
        {
            return ("");
        }


    }
}//package com.clubpenguin.lib.vo.puffle
