//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import com.clubpenguin.endscreens.mediator.MinigameEndScreenViewMediator;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.events.MouseEvent;
    import flash.display.SimpleButton;

    public class MiniGameEndScreensView extends BaseEmbeddedAssetView 
    {

        private var _mediator:MinigameEndScreenViewMediator;
        private var _localizer:ILocalizationManager;
        private var _frame:String;

        public function MiniGameEndScreensView()
        {
            super(EndGameViewAssets.MainSkin, MiniGameEndScreensConstants.SKIN_INSTANCE_NAME_MAIN);
            instance.visible = false;
        }

        public function testText():TextField
        {
            return (view["testText"] as TextField);
        }

        public function initView(mediator:MinigameEndScreenViewMediator, localizer:ILocalizationManager):void
        {
            this._mediator = mediator;
            this._localizer = localizer;
        }

        public function showFrame(frame:String):void
        {
            this._frame = frame;
            if (view == null)
            {
                onCompleted.addOnce(this.updateFrameAndText);
            }
            else
            {
                this.updateFrameAndText();
            };
        }

        private function correctGameName(gameName:String):String
        {
            var adjustedName:String = gameName;
            switch (gameName)
            {
                case "four":
                    adjustedName = this._localizer.getLocalizedString(gameName);
                    break;
                case "mancala":
                    adjustedName = "Mancala";
                    break;
                case "Smoothie":
                    adjustedName = "Smoothie Smash";
                    break;
                case "Card-Jitsu Fire":
                    adjustedName = "Card-Jitsu : Fire";
                    break;
                case "Card-Jitsu Water":
                    adjustedName = "Card-Jitsu : Water";
                    break;
                case "Parafusos":
                    adjustedName = "Porcas e Parafusos";
                    break;
                case "Schrauben":
                    adjustedName = "Die Schrauben Sind Los";
                    break;
                case "Tuercas":
                    adjustedName = "Tuercas y tornillos";
                    break;
            };
            return (adjustedName);
        }

        private function updateFrameAndText():void
        {
            (view as MovieClip).gotoAndStop(this._frame);
            (view[MiniGameEndScreensConstants.GAME_LOGO] as MovieClip).gotoAndStop((this._mediator.fetchFrameName() as String));
            instance.visible = true;
            this.updateText(this._frame);
            this.setupButtonListeners((!(this._frame == MiniGameEndScreensConstants.FRAME_STAMPS)));
        }

        private function updateText(frame:String):void
        {
            var str:String = this._mediator.fetchGameName();
            var gameName:String = this.correctGameName(str);
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.MAIN_GAME_TITLE_TEXT]).localTextField, gameName);
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.MAIN_DONE_TEXT]).localTextField, this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_MAIN_DONE));
            if (frame != MiniGameEndScreensConstants.FRAME_STAMPS)
            {
                LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.MAIN_SPEND_TEXT]).localTextField, this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_MAIN_SPEND));
                LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.MAIN_CLOTHES_TEXT]).localTextField, this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_MAIN_CLOTHES));
                LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.MAIN_PET_TEXT]).localTextField, this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_MAIN_PET));
                LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.MAIN_IGLOO_TEXT]).localTextField, this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_MAIN_IGLOO));
            };
        }

        private function setupButtonListeners(spending:Boolean):void
        {
            (view[MiniGameEndScreensConstants.CLOSE_BUTTON] as MovieClip).addEventListener(MouseEvent.CLICK, this._mediator.exit);
            (view[MiniGameEndScreensConstants.DONE_BUTTON] as SimpleButton).addEventListener(MouseEvent.CLICK, this._mediator.exit);
            if (spending)
            {
                (view[MiniGameEndScreensConstants.CLOTHES_BUTTON] as SimpleButton).addEventListener(MouseEvent.CLICK, this._mediator.exitToClothes);
                (view[MiniGameEndScreensConstants.PET_BUTTON] as SimpleButton).addEventListener(MouseEvent.CLICK, this._mediator.exitToPet);
                (view[MiniGameEndScreensConstants.IGLOO_BUTTON] as SimpleButton).addEventListener(MouseEvent.CLICK, this._mediator.exitToIgloo);
            };
        }


    }
}//package com.clubpenguin.endscreens.view
