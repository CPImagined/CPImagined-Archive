//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model.state
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.StateChangeEvent;

    public class BaseState extends EventDispatcher 
    {


        final private function init():void
        {
            throw (new Error("BaseState.init() is an abstrac function that must be overridden"));
        }

        protected function sendChangeState(nextState:String):void
        {
            dispatchEvent(new StateChangeEvent(StateChangeEvent.CHANGE_STATE, nextState));
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model.state
