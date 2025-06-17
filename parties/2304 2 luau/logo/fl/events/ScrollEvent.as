package fl.events
{
    import flash.events.*;

    public class ScrollEvent extends Event
    {
        private var _direction:String;
        private var _delta:Number;
        private var _position:Number;
        public static const SCROLL:String = "scroll";

        public function ScrollEvent(param1:String, param2:Number, param3:Number)
        {
            super(ScrollEvent.SCROLL, false, false);
            this._direction = param1;
            this._delta = param2;
            this._position = param3;
            return;
        }// end function

        public function get direction() : String
        {
            return this._direction;
        }// end function

        public function get delta() : Number
        {
            return this._delta;
        }// end function

        public function get position() : Number
        {
            return this._position;
        }// end function

        override public function toString() : String
        {
            return formatToString("ScrollEvent", "type", "bubbles", "cancelable", "direction", "delta", "position");
        }// end function

        override public function clone() : Event
        {
            return new ScrollEvent(this._direction, this._delta, this._position);
        }// end function

    }
}
