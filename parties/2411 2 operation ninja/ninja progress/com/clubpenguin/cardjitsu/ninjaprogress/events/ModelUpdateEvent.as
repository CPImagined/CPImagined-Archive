//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.events
{
    import flash.events.Event;

    public class ModelUpdateEvent extends Event 
    {

        public static const MODEL_UPDATED:String = "modelReady";

        public var propertyUpdated:String;

        public function ModelUpdateEvent(_arg_1:String, propertyUpdated:String)
        {
            super(_arg_1);
            this.propertyUpdated = propertyUpdated;
        }

        override public function clone():Event
        {
            return (new ModelUpdateEvent(this.type, this.propertyUpdated));
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.events
