//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals.natives
{
    import org.osflash.signals.IDeluxeSignal;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import flash.errors.IllegalOperationError;

    public class NativeSignal implements IDeluxeSignal, INativeDispatcher 
    {

        protected var _eventClass:Class;
        protected var listenerBoxes:Array;
        protected var _target:IEventDispatcher;
        protected var _eventType:String;

        public function NativeSignal(target:IEventDispatcher, eventType:String, eventClass:Class=null)
        {
            _target = target;
            _eventType = eventType;
            _eventClass = ((eventClass) || (Event));
            listenerBoxes = [];
        }

        public function dispatch(event:Event):Boolean
        {
            if (!(event is _eventClass))
            {
                throw (new ArgumentError((((("Event object " + event) + " is not an instance of ") + _eventClass) + ".")));
            };
            if (event.type != _eventType)
            {
                throw (new ArgumentError((((("Event object has incorrect type. Expected <" + _eventType) + "> but was <") + event.type) + ">.")));
            };
            return (_target.dispatchEvent(event));
        }

        public function addOnce(listener:Function, priority:int=0):Function
        {
            registerListener(listener, true, priority);
            return (listener);
        }

        public function remove(listener:Function):Function
        {
            var listenerIndex:int = indexOfListener(listener);
            if (listenerIndex == -1)
            {
                return (listener);
            };
            var listenerBox:Object = listenerBoxes.splice(listenerIndex, 1)[0];
            _target.removeEventListener(_eventType, listenerBox.execute);
            return (listener);
        }

        public function get eventClass():Class
        {
            return (_eventClass);
        }

        public function get valueClasses():Array
        {
            return ([_eventClass]);
        }

        public function get target():IEventDispatcher
        {
            return (_target);
        }

        public function add(listener:Function, priority:int=0):Function
        {
            registerListener(listener, false, priority);
            return (listener);
        }

        public function set target(value:IEventDispatcher):void
        {
            _target = value;
        }

        protected function indexOfListener(listener:Function):int
        {
            var i:int = listenerBoxes.length;
            while (i--)
            {
                if (listenerBoxes[i].listener == listener)
                {
                    return (i);
                };
            };
            return (-1);
        }

        public function get numListeners():uint
        {
            return (listenerBoxes.length);
        }

        public function get eventType():String
        {
            return (_eventType);
        }

        protected function registerListener(listener:Function, once:Boolean=false, priority:int=0):void
        {
            var prevlistenerBox:Object;
            var signal:NativeSignal;
            if (listener.length != 1)
            {
                throw (new ArgumentError("Listener for native event must declare exactly 1 argument."));
            };
            var prevListenerIndex:int = indexOfListener(listener);
            if (prevListenerIndex >= 0)
            {
                prevlistenerBox = listenerBoxes[prevListenerIndex];
                if (((prevlistenerBox.once) && (!(once))))
                {
                    throw (new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first."));
                };
                if (((!(prevlistenerBox.once)) && (once)))
                {
                    throw (new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first."));
                };
                return;
            };
            var listenerBox:Object = {
                "listener":listener,
                "once":once,
                "execute":listener
            };
            if (once)
            {
                signal = this;
                listenerBox.execute = function (event:Event):void
                {
                    signal.remove(listener);
                    listener(event);
                };
            };
            listenerBoxes[listenerBoxes.length] = listenerBox;
            _target.addEventListener(_eventType, listenerBox.execute, false, priority);
        }

        public function removeAll():void
        {
            var i:int = listenerBoxes.length;
            while (i--)
            {
                remove((listenerBoxes[i].listener as Function));
            };
        }


    }
}//package org.osflash.signals.natives
