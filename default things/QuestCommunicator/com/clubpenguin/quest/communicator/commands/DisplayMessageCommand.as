//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.quest.communicator.mediator.QuestCommunicatorMediator;
    import com.clubpenguin.lib.util.Log;

    public class DisplayMessageCommand extends SignalCommand 
    {

        private const DEFAULT_MESSAGE_DURATION:int = 8000;

        [Inject]
        public var mediator:QuestCommunicatorMediator;
        [Inject]
        public var payload:Object;


        override public function execute():void
        {
            var message:String = this.payload.message;
            var expressionID:int = (this.payload.expression as int);
            var duration:int = ((this.payload.duration) ? (this.payload.duration as int) : this.DEFAULT_MESSAGE_DURATION);
            Log.info(((((("Quest Command - DisplayMessageCommand - expression: " + expressionID) + " message: ") + message) + " duration") + duration));
            this.mediator.showCommunicator(message, expressionID, duration);
        }


    }
}//package com.clubpenguin.quest.communicator.commands
