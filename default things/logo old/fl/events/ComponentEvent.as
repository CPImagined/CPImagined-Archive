package fl.events
{
    import flash.events.*;

    public class ComponentEvent extends Event
    {
        public static const BUTTON_DOWN:String = "buttonDown";
        public static const LABEL_CHANGE:String = "labelChange";
        public static const HIDE:String = "hide";
        public static const SHOW:String = "show";
        public static const RESIZE:String = "resize";
        public static const MOVE:String = "move";
        public static const ENTER:String = "enter";

        public function ComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("ComponentEvent", "type", "bubbles", "cancelable");
        }// end function

        override public function clone() : Event
        {
            return new ComponentEvent(type, bubbles, cancelable);
        }// end function

    }
}
