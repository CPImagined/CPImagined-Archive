//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core.events
{
    import flash.events.Event;

    public class FontLibraryEvent extends Event 
    {

        public static const LOAD_COMPLETE:String = "fontLibLoadComplete";
        public static const FONT_CHANGED:String = "fontChanged";

        private var _target:Object;

        public function FontLibraryEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false, target:Object=null)
        {
            super(_arg_1, bubbles, cancelable);
            this._target = target;
        }

        override public function get target():Object
        {
            return (this._target);
        }

        override public function clone():Event
        {
            return (new FontLibraryEvent(this.type, this.bubbles, this.cancelable, this.target));
        }


    }
}//package com.clubpenguin.tools.localtext.core.events
