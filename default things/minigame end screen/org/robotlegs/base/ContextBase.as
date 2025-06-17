//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.base
{
    import org.robotlegs.core.IContext;
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class ContextBase implements IContext, IEventDispatcher 
    {

        protected var _eventDispatcher:IEventDispatcher;

        public function ContextBase()
        {
            this._eventDispatcher = new EventDispatcher(this);
        }

        public function get eventDispatcher():IEventDispatcher
        {
            return (this._eventDispatcher);
        }

        public function addEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            this.eventDispatcher.addEventListener(_arg_1, listener, useCapture, priority);
        }

        public function dispatchEvent(event:Event):Boolean
        {
            if (this.eventDispatcher.hasEventListener(event.type))
            {
                return (this.eventDispatcher.dispatchEvent(event));
            };
            return (false);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this.eventDispatcher.hasEventListener(_arg_1));
        }

        public function removeEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false):void
        {
            this.eventDispatcher.removeEventListener(_arg_1, listener, useCapture);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this.eventDispatcher.willTrigger(_arg_1));
        }


    }
}//package org.robotlegs.base
