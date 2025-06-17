//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import flash.events.IEventDispatcher;
    import org.robotlegs.core.IEventMap;
    import org.robotlegs.base.EventMap;
    import flash.events.Event;

    public class Actor 
    {

        protected var _eventDispatcher:IEventDispatcher;
        protected var _eventMap:IEventMap;


        public function get eventDispatcher():IEventDispatcher
        {
            return (this._eventDispatcher);
        }

        [Inject]
        public function set eventDispatcher(value:IEventDispatcher):void
        {
            this._eventDispatcher = value;
        }

        protected function get eventMap():IEventMap
        {
            return ((this._eventMap) || (this._eventMap = new EventMap(this.eventDispatcher)));
        }

        protected function dispatch(event:Event):Boolean
        {
            if (this.eventDispatcher.hasEventListener(event.type))
            {
                return (this.eventDispatcher.dispatchEvent(event));
            };
            return (false);
        }


    }
}//package org.robotlegs.mvcs
