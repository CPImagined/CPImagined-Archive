//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import org.robotlegs.base.MediatorBase;
    import flash.display.DisplayObjectContainer;
    import org.robotlegs.core.IMediatorMap;
    import flash.events.IEventDispatcher;
    import org.robotlegs.core.IEventMap;
    import org.robotlegs.base.EventMap;
    import flash.events.Event;

    public class Mediator extends MediatorBase 
    {

        [Inject]
        public var contextView:DisplayObjectContainer;
        [Inject]
        public var mediatorMap:IMediatorMap;
        protected var _eventDispatcher:IEventDispatcher;
        protected var _eventMap:IEventMap;


        override public function preRemove():void
        {
            if (this._eventMap)
            {
                this._eventMap.unmapListeners();
            };
            super.preRemove();
        }

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

        protected function addViewListener(_arg_1:String, listener:Function, eventClass:Class=null, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void
        {
            this.eventMap.mapListener(IEventDispatcher(viewComponent), _arg_1, listener, eventClass, useCapture, priority, useWeakReference);
        }

        protected function addContextListener(_arg_1:String, listener:Function, eventClass:Class=null, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void
        {
            this.eventMap.mapListener(this.eventDispatcher, _arg_1, listener, eventClass, useCapture, priority, useWeakReference);
        }


    }
}//package org.robotlegs.mvcs
