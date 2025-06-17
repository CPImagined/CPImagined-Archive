//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.endscreens.view.MiniGameEndScreensView;
    import com.clubpenguin.endscreens.controller.MiniGameEndScreensController;
    import com.clubpenguin.endscreens.model.MiniGameEndScreensModel;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.endscreens.MiniGameEndScreensContext;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.playdom.tracker.Tracker;
    import flash.events.Event;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.geom.Point;

    public class MinigameEndScreenViewMediator extends Mediator 
    {

        public const BI_CONTEXT_MINIGAME_END_SCREENS:String = "minigame_end_screen";
        public const CLOTHING_BUTTON:String = "buy_clothing_button";
        public const ADOPT_PUFFLE_BUTTON:String = "adopt_puffle_button";
        public const DECORATE_IGLOO_BUTTON:String = "decorate_igloo_button";

        [Inject]
        public var view:MiniGameEndScreensView;
        [Inject]
        public var controller:MiniGameEndScreensController;
        [Inject]
        public var model:MiniGameEndScreensModel;
        [Inject]
        public var closeSignal:CloseModuleSignal;
        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var context:MiniGameEndScreensContext;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var tracker:Tracker;


        override public function onRegister():void
        {
            this.view.initView(this, this.localizer);
        }

        public function exit(event:Event):void
        {
            this.closeSignal.dispatch(this.context.contextView);
        }

        public function exitToClothes(event:Event):void
        {
            this.sendJoinRoom(MiniGameEndScreensConstants.CLOTHING_SHOP, this.model.exitRoomXpos, this.model.exitRoomYpos);
            this.closeSignal.dispatch(this.context.contextView);
        }

        public function exitToPet(event:Event):void
        {
            this.sendJoinRoom(MiniGameEndScreensConstants.PET_SHOP, this.model.exitRoomXpos, this.model.exitRoomYpos);
            this.closeSignal.dispatch(this.context.contextView);
        }

        public function exitToIgloo(event:Event):void
        {
            this.sendJoinRoom(MiniGameEndScreensConstants.IGLOO, this.model.exitRoomXpos, this.model.exitRoomYpos);
            this.closeSignal.dispatch(this.context.contextView);
        }

        public function fetchGameName():String
        {
            return (this.model.gameName);
        }

        public function fetchFrameName():String
        {
            return (this.model.frameName);
        }

        private function sendJoinRoom(roomName:String, xPos:int, yPos:int):void
        {
            var bridgeMessageType:String = ((roomName == "igloo") ? AVMBridgeMessage.MSG_TELEPORT_TO_MY_IGLOO : AVMBridgeMessage.MSG_JOIN_ROOM);
            var joinRoomMessage:AVMBridgeMessage = new AVMBridgeMessage(bridgeMessageType);
            joinRoomMessage.data = new Object();
            joinRoomMessage.data.roomName = roomName;
            joinRoomMessage.data.position = new Point(xPos, yPos);
            this.bridge.send(joinRoomMessage);
        }


    }
}//package com.clubpenguin.endscreens.mediator
