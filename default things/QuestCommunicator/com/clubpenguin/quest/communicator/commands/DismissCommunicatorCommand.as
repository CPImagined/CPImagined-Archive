//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.quest.communicator.mediator.QuestCommunicatorMediator;

    public class DismissCommunicatorCommand extends SignalCommand 
    {

        [Inject]
        public var mediator:QuestCommunicatorMediator;


        override public function execute():void
        {
            this.mediator.dismissCommunicator();
        }


    }
}//package com.clubpenguin.quest.communicator.commands
