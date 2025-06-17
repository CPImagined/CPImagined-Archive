//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.puffle
{
    import com.clubpenguin.lib.vo.IVO;
    import org.osflash.signals.Signal;

    public class MoodVO implements IVO 
    {

        public const voUpdated:Signal = new Signal(MoodVO);

        private var _invalidated:Boolean = false;
        public var puffleID:int;
        private var _superHappy:Boolean = false;
        private var _happy:Boolean = false;
        private var _sad:Boolean = false;
        private var _angry:Boolean = false;
        private var _tired:Boolean = false;
        private var _hungry:Boolean = false;
        private var _dirty:Boolean = false;

        public function MoodVO():void
        {
        }

        public static function getBlankMood():MoodVO
        {
            var blankMoodVO:MoodVO = new (MoodVO)();
            return (blankMoodVO);
        }


        public function destroy():void
        {
            this.voUpdated.removeAll();
        }

        public function getAllMoods():Object
        {
            var obj:Object = new Object();
            obj.superHappy = this.superHappy;
            obj.happy = this.happy;
            obj.sad = this.sad;
            obj.angry = this.angry;
            obj.tired = this.tired;
            obj.hungry = this.hungry;
            obj.dirty = this.dirty;
            return (obj);
        }

        public function set superHappy(flag:Boolean):void
        {
            if (flag != this._superHappy)
            {
                this._superHappy = flag;
                this._invalidated = true;
            };
        }

        public function get superHappy():Boolean
        {
            return (this._superHappy);
        }

        public function set happy(flag:Boolean):void
        {
            if (flag != this._happy)
            {
                this._happy = flag;
                this._invalidated = true;
            };
        }

        public function get happy():Boolean
        {
            return (this._happy);
        }

        public function set sad(flag:Boolean):void
        {
            if (flag != this._sad)
            {
                this._sad = flag;
                this._invalidated = true;
            };
        }

        public function get sad():Boolean
        {
            return (this._sad);
        }

        public function set angry(flag:Boolean):void
        {
            if (flag != this._angry)
            {
                this._angry = flag;
                this._invalidated = true;
            };
        }

        public function get angry():Boolean
        {
            return (this._angry);
        }

        public function set tired(flag:Boolean):void
        {
            if (flag != this._tired)
            {
                this._tired = flag;
                this._invalidated = true;
            };
        }

        public function get tired():Boolean
        {
            return (this._tired);
        }

        public function set hungry(flag:Boolean):void
        {
            if (flag != this._hungry)
            {
                this._hungry = flag;
                this._invalidated = true;
            };
        }

        public function get hungry():Boolean
        {
            return (this._hungry);
        }

        public function set dirty(flag:Boolean):void
        {
            if (flag != this._dirty)
            {
                this._dirty = flag;
                this._invalidated = true;
            };
        }

        public function get dirty():Boolean
        {
            return (this._dirty);
        }

        public function equals(vo:IVO):Boolean
        {
            return (vo.id == this.id);
        }

        public function update(vo:IVO):void
        {
            var moodVO:MoodVO = (vo as MoodVO);
            this.superHappy = moodVO.superHappy;
            this.happy = moodVO.happy;
            this.sad = moodVO.sad;
            this.angry = moodVO.angry;
            this.tired = moodVO.tired;
            this.hungry = moodVO.hungry;
            this.dirty = moodVO.dirty;
            if (this._invalidated)
            {
                this._invalidated = false;
                this.voUpdated.dispatch(this);
            };
        }

        public function get id():int
        {
            return (-1);
        }

        public function toString():String
        {
            return ((((((((((((((("puffleID:" + this.puffleID) + ", superHappy:") + this.superHappy) + ", happy:") + this.happy) + ", sad:") + this.sad) + ", angry:") + this.angry) + ", tired:") + this.tired) + ", hungry:") + this.hungry) + ", dirty:") + this.dirty);
        }


    }
}//package com.clubpenguin.lib.vo.puffle
