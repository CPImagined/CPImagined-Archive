//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model.state
{
    import flash.utils.Dictionary;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.StateChangeEvent;

    public final class StateMachine 
    {

        public var states:Dictionary;
        private var _currentState:String;

        public function StateMachine()
        {
            this.states = new Dictionary();
        }

        public function addState(stateConst:String, state:IState):void
        {
            this.states[stateConst] = state;
        }

        public function getCurrentState():IState
        {
            return (this.states[this._currentState] as IState);
        }

        public function getCurrentStateName():String
        {
            return (this._currentState);
        }

        public function hasState(stateConst:String):Boolean
        {
            return (!(this.states[stateConst] == undefined));
        }

        public function changeState(nextState:String):void
        {
            if (this.getCurrentState())
            {
                this.getCurrentState().exit();
                this.getCurrentState().removeEventListener(StateChangeEvent.CHANGE_STATE, this.onChangeState);
            };
            if (this.hasState(nextState))
            {
                this._currentState = nextState;
                this.getCurrentState().enter();
                this.getCurrentState().addEventListener(StateChangeEvent.CHANGE_STATE, this.onChangeState);
            }
            else
            {
                throw (new Error((("Error: State " + nextState) + " does not exist at StateMachine.changeState")));
            };
        }

        private function onChangeState(event:StateChangeEvent):void
        {
            this.changeState(event.state);
        }

        public function destroy():void
        {
            var state:IState;
            for each (state in this.states)
            {
                state.destroy();
            };
            this.states = new Dictionary();
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model.state
