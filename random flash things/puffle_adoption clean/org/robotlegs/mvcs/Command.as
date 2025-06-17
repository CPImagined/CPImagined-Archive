//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import flash.display.DisplayObjectContainer;
    import org.robotlegs.core.ICommandMap;
    import flash.events.IEventDispatcher;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediatorMap;
    import flash.events.Event;

    public class Command 
    {

        [Inject]
        public var contextView:DisplayObjectContainer;
        [Inject]
        public var commandMap:ICommandMap;
        [Inject]
        public var eventDispatcher:IEventDispatcher;
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var mediatorMap:IMediatorMap;


        public function execute():void
        {
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
