//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator.mediator
{
    import com.clubpenguin.quest.communicator.QuestCommunicatorContext;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.quest.communicator.view.QuestCommunicatorView;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.quest.communicator.view.EmbeddedQuestCommunicatorAssets;
    import flash.events.MouseEvent;
    import flash.utils.setTimeout;
    import flash.utils.clearTimeout;
    import flash.utils.*;

    public class QuestCommunicatorMediator 
    {

        [Inject]
        public var context:QuestCommunicatorContext;
        [Inject]
        public var localizer:ILocalizationManager;
        private var translatedBubbleText:String;
        private var expression:String;
        private var view:QuestCommunicatorView;
        private var messageQueue:Array;
        private var isMessageDisplayed:Boolean = false;
        private var messageTimeout:uint;

        public function QuestCommunicatorMediator()
        {
            Log.info("QuestCommunicatorMediator");
        }

        public function init():void
        {
            Log.info("QuestCommunicatorMediator - init");
            this.view = new QuestCommunicatorView(EmbeddedQuestCommunicatorAssets.HALLOWEEN_ASSET);
            this.view.onCompleted.addOnce(this.onViewAdded);
            this.messageQueue = new Array();
        }

        private function onViewAdded():void
        {
            this.context.contextView.addChild(this.view);
            this.view.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        public function showCommunicator(messageToken:String, expressionFrame:Number, messageDuration:int):void
        {
            Log.info(((((("QuestCommunicatorMediator - showCommunicator - messageToken: " + messageToken) + " expressionFrame: ") + expressionFrame) + " duration: ") + messageDuration));
            trace(((("QuestCommunicatorMediator showCommunicator - messageToken: " + messageToken) + " view: ") + this.view));
            var messagePayload:Object = {
                "message":this.getLocalizedText(messageToken),
                "expression":expressionFrame,
                "duration":messageDuration
            };
            this.addMessageToQueue(messagePayload);
        }

        public function addMessageToQueue(messagePayload:Object):void
        {
            this.messageQueue.push(messagePayload);
            this.executeQueuedMessages();
        }

        public function executeQueuedMessages():void
        {
            var queuedMessagePayload:Object;
            if (((this.messageQueue.length > 0) && (!(this.isMessageDisplayed))))
            {
                queuedMessagePayload = this.messageQueue[0];
                this.view.startViewAnimation(queuedMessagePayload.message, queuedMessagePayload.expression);
                this.messageTimeout = setTimeout(this.removeCurrentMessageFromQueue, queuedMessagePayload.duration);
                this.isMessageDisplayed = true;
            };
        }

        public function removeCurrentMessageFromQueue():void
        {
            this.view.dismissCommunicator();
            this.messageQueue.splice(0, 1);
            clearTimeout(this.messageTimeout);
            this.isMessageDisplayed = false;
            this.executeQueuedMessages();
        }

        private function onMouseUp(mouseEvent:MouseEvent):void
        {
            this.removeCurrentMessageFromQueue();
        }

        public function dismissCommunicator():void
        {
            this.view.dismissCommunicator();
            this.messageQueue = new Array();
            clearTimeout(this.messageTimeout);
            this.isMessageDisplayed = false;
        }

        private function getLocalizedText(token:String):String
        {
            return (this.localizer.getLocalizedString(token));
        }


    }
}//package com.clubpenguin.quest.communicator.mediator
