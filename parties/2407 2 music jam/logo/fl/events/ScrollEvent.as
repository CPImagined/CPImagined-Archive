//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.events
{
    import flash.events.Event;

    public class ScrollEvent extends Event 
    {

        public static const SCROLL:String = "scroll";

        private var _direction:String;
        private var _delta:Number;
        private var _position:Number;

        public function ScrollEvent(_arg_1:String, _arg_2:Number, _arg_3:Number)
        {
            super(ScrollEvent.SCROLL, false, false);
            this._direction = _arg_1;
            this._delta = _arg_2;
            this._position = _arg_3;
        }

        public function get direction():String
        {
            return (this._direction);
        }

        public function get delta():Number
        {
            return (this._delta);
        }

        public function get position():Number
        {
            return (this._position);
        }

        override public function toString():String
        {
            return (formatToString("ScrollEvent", "type", "bubbles", "cancelable", "direction", "delta", "position"));
        }

        override public function clone():Event
        {
            return (new ScrollEvent(this._direction, this._delta, this._position));
        }


    }
}//package fl.events
