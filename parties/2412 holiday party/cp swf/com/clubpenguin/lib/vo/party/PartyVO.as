//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.party
{
    import com.clubpenguin.lib.vo.IVO;

    public class PartyVO implements IVO 
    {

        private var _isActive:Boolean = false;


        public function destroy():void
        {
        }

        public function update(vo:IVO):void
        {
        }

        public function equals(vo:IVO):Boolean
        {
            if (this === vo)
            {
                return (true);
            };
            return (false);
        }

        public function toString():String
        {
            return (null);
        }

        public function get id():int
        {
            return (0);
        }

        public function get isActive():Boolean
        {
            return (this._isActive);
        }

        public function set isActive(bool:Boolean):void
        {
            this._isActive = bool;
        }


    }
}//package com.clubpenguin.lib.vo.party
