package com.clubpenguin.tools.localtext.core.events
{
    import flash.events.*;

    public class FontLibraryEvent extends Event
    {
        private var _target:Object;
        public static const LOAD_COMPLETE:String = "fontLibLoadComplete";
        public static const FONT_CHANGED:String = "fontChanged";

        public function FontLibraryEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
        {
            super(param1, param2, param3);
            this._target = param4;
            return;
        }// end function

        override public function get target() : Object
        {
            return this._target;
        }// end function

        override public function clone() : Event
        {
            return new FontLibraryEvent(this.type, this.bubbles, this.cancelable, this.target);
        }// end function

    }
}
