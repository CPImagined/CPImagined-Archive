//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.quest.communicator.service.QuestCommunicatorBridgeService;
    import com.clubpenguin.quest.communicator.mediator.QuestCommunicatorMediator;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.quest.communicator.commands.DisplayMessageCommand;
    import com.clubpenguin.quest.communicator.commands.DismissCommunicatorCommand;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.quest.communicator.view.QuestCommunicatorView;

    public class QuestCommunicatorContext extends BaseModuleContext 
    {

        private var bridgeService:QuestCommunicatorBridgeService = new QuestCommunicatorBridgeService();
        private var mediator:QuestCommunicatorMediator = new QuestCommunicatorMediator();

        public function QuestCommunicatorContext(contextView:BaseModule, injector:IInjector)
        {
            super(contextView, injector);
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(QuestCommunicatorContext, this);
            injector.mapValue(QuestCommunicatorMediator, this.mediator);
            injector.injectInto(this.mediator);
            signalCommandMap.mapSignal(this.bridgeService.displayQuestMessage, DisplayMessageCommand);
            signalCommandMap.mapSignal(this.bridgeService.dismissQuestMessage, DismissCommunicatorCommand);
        }

        override public function startup():void
        {
            this.mediator.init();
            this.bridgeService.init(injector.getInstance(IAppModel));
        }

        override public function shutdown():void
        {
            super.shutdown();
            injector.unmap(QuestCommunicatorContext);
            mediatorMap.unmapView(QuestCommunicatorView);
        }


    }
}//package com.clubpenguin.quest.communicator
