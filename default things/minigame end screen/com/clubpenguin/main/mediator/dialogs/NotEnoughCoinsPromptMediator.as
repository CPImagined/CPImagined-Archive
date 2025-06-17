//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator.dialogs
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.view.NotEnoughCoinsPromptView;
    import com.clubpenguin.main.vo.ComplexPromptVO;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.playdom.tracker.Tracker;
    import flash.display.MovieClip;
    import org.osflash.signals.Signal;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.utils.getTimer;
    import org.robotlegs.core.IMediatorMap;

    public class NotEnoughCoinsPromptMediator extends Mediator 
    {

        private static const PLAY_GAMES_BUTTON:String = "play_games_btn";
        private static const WALK_PUFFLE_BUTTON:String = "walk_puffle_btn";
        private static const NO_THANKS_BUTTON:String = "no_thanks_btn";
        private static const CLOSE_BUTTON:String = "close_btn";
        private static const BUTTON_UP_FRAME:String = "up";
        private static const BUTTON_OVER_FRAME:String = "over";
        private static const BUTTON_DOWN_FRAME:String = "down";
        private static const DESCRIPTION_TEXT_GENERIC:String = "description_txt_generic_container";
        private static const DESCRIPTION_TEXT_MAIL:String = "description_txt_mail_container";
        private static const BUTTONS_MOVIECLIP:String = "buttons_mc";
        private static const BUTTONS_MOVIECLIP_HAS_PUFFLE_FRAME:String = "hasPuffle";
        private static const BUTTONS_MOVIECLIP_NO_PUFFLE_FRAME:String = "noPuffle";
        private static const PLAY_GAMES_MOVIECLIP:String = "play_games_mc";
        private static const WALK_PUFFLE_MOVIECLIP:String = "walk_puffle_mc";
        private static const VAULT_MOVIECLIP:String = "vault_mc";
        private static const BI_CONTEXT_GENERAL_ERROR:String = "General Error";
        private static const BI_CONTEXT_NOT_ENOUGH_COINS:String = "not_enough_coins";
        private static const BI_ACTION_PLAY_GAMES:String = "play_games";
        private static const BI_ACTION_WALK_PUFFLE:String = "walk_puffle";
        private static const BI_ACTION_CLOSE:String = "close";
        private static var CATEGORY_GAMES_ID:Number = 1;
        private static var PROMPT_CONTEXT_MAIL:String = "mail";
        private static var STAGE_WIDTH:Number = 760;
        private static var STAGE_HEIGHT:Number = 480;

        [Inject]
        public var notEnoughCoinsPromptView:NotEnoughCoinsPromptView;
        [Inject]
        public var complexPromptVO:ComplexPromptVO;
        [Inject]
        public var mainContext:MainContext;
        [Inject]
        public var signalBus:IAppSignalBus;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var tracker:Tracker;
        private var _currentFrame:String;
        private var view:MovieClip;


        override public function onRegister():void
        {
            if (!this.notEnoughCoinsPromptView.loaded)
            {
                this.notEnoughCoinsPromptView.onCompleted.addOnce(this.onAssetLoaded);
            }
            else
            {
                this.onAssetLoaded();
            };
        }

        private function onAssetLoaded():void
        {
            this.view = this.notEnoughCoinsPromptView.assetView;
            var promptData:Object = this.complexPromptVO.data;
            Signal(this.signalBus.getClosePopups()).add(this.cleanUp);
            this.notEnoughCoinsPromptView.printHeirarchy(this.view);
            this.notEnoughCoinsPromptView.x = ((STAGE_WIDTH - MovieClip(this.view[VAULT_MOVIECLIP]).width) * 0.5);
            this.notEnoughCoinsPromptView.y = ((STAGE_HEIGHT - MovieClip(this.view[VAULT_MOVIECLIP]).height) * 0.5);
            if (promptData.hasPuffle == true)
            {
                this._currentFrame = BUTTONS_MOVIECLIP_HAS_PUFFLE_FRAME;
            }
            else
            {
                this._currentFrame = BUTTONS_MOVIECLIP_NO_PUFFLE_FRAME;
            };
            MovieClip(this.view[BUTTONS_MOVIECLIP]).gotoAndStop(this._currentFrame);
            if (promptData.context == PROMPT_CONTEXT_MAIL)
            {
                this.view[DESCRIPTION_TEXT_GENERIC].visible = false;
            }
            else
            {
                this.view[DESCRIPTION_TEXT_MAIL].visible = false;
            };
            this.setUpButton(this.view[BUTTONS_MOVIECLIP][PLAY_GAMES_MOVIECLIP][PLAY_GAMES_BUTTON]);
            this.setUpButton(this.view[NO_THANKS_BUTTON]);
            this.setUpButton(this.view[CLOSE_BUTTON]);
            if (this._currentFrame == BUTTONS_MOVIECLIP_HAS_PUFFLE_FRAME)
            {
                this.setUpButton(this.view[BUTTONS_MOVIECLIP][WALK_PUFFLE_MOVIECLIP][WALK_PUFFLE_BUTTON]);
            };
        }

        private function setUpButton(buttonMC:MovieClip):void
        {
            buttonMC.gotoAndStop(BUTTON_UP_FRAME);
            buttonMC.buttonMode = true;
            buttonMC.mouseChildren = false;
            buttonMC.addEventListener(MouseEvent.CLICK, this.onButtonClicked);
            buttonMC.addEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            buttonMC.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
            buttonMC.addEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
        }

        private function onButtonMouseOver(event:MouseEvent):void
        {
            MovieClip(event.currentTarget).gotoAndStop(BUTTON_OVER_FRAME);
        }

        private function onButtonMouseDown(event:MouseEvent):void
        {
            MovieClip(event.currentTarget).gotoAndStop(BUTTON_DOWN_FRAME);
        }

        private function onButtonMouseOut(event:MouseEvent):void
        {
            MovieClip(event.currentTarget).gotoAndStop(BUTTON_UP_FRAME);
        }

        private function onButtonClicked(event:MouseEvent):void
        {
            var action:String;
            var buttonClicked:String = MovieClip(event.currentTarget).name;
            switch (buttonClicked)
            {
                case PLAY_GAMES_BUTTON:
                    action = BI_ACTION_PLAY_GAMES;
                    this.closePopups();
                    this.openGamesMap();
                    break;
                case WALK_PUFFLE_BUTTON:
                    action = BI_ACTION_WALK_PUFFLE;
                    this.closePopups();
                    this.sendPlayerToOwnIgloo();
                    break;
                case NO_THANKS_BUTTON:
                case CLOSE_BUTTON:
                default:
                    action = BI_ACTION_CLOSE;
            };
            this.closePrompt();
            var payload:Object = new Object();
            payload.message = buttonClicked;
        }

        private function openGamesMap():void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_OPEN_MAP_WITH_CATEGORY);
            message.data = new Object();
            message.data.mapCategory = CATEGORY_GAMES_ID;
            this.bridge.send(message);
        }

        private function sendPlayerToOwnIgloo():void
        {
            var loadRoomStartTime:int = getTimer();
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_TELEPORT_TO_MY_IGLOO);
            message.data = new Object();
            message.data.loadRoomStartTime = loadRoomStartTime;
            this.bridge.send(message);
        }

        private function closePopups():void
        {
            Signal(this.signalBus.getClosePopups()).dispatch();
        }

        private function closePrompt():void
        {
            var mediatorMap:IMediatorMap = this.mainContext.getMediatorMap();
            Signal(this.signalBus.getCloseView()).dispatch(this.view);
            this.cleanUp();
            mediatorMap.unmapView(NotEnoughCoinsPromptView);
        }

        private function cleanUp():void
        {
            this.cleanUpButton(this.view[BUTTONS_MOVIECLIP][PLAY_GAMES_MOVIECLIP][PLAY_GAMES_BUTTON]);
            this.cleanUpButton(this.view[NO_THANKS_BUTTON]);
            this.cleanUpButton(this.view[CLOSE_BUTTON]);
            if (this._currentFrame == BUTTONS_MOVIECLIP_HAS_PUFFLE_FRAME)
            {
                this.cleanUpButton(this.view[BUTTONS_MOVIECLIP][WALK_PUFFLE_MOVIECLIP][WALK_PUFFLE_BUTTON]);
            };
        }

        private function cleanUpButton(buttonMC:MovieClip):void
        {
            buttonMC.removeEventListener(MouseEvent.CLICK, this.onButtonClicked);
            buttonMC.removeEventListener(MouseEvent.MOUSE_OVER, this.onButtonMouseOver);
            buttonMC.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
            buttonMC.removeEventListener(MouseEvent.MOUSE_OUT, this.onButtonMouseOut);
        }


    }
}//package com.clubpenguin.main.mediator.dialogs
