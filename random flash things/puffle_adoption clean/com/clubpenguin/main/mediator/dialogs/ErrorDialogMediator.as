//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator.dialogs
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.view.ErrorDialogView;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.vo.ErrorVO;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.events.MouseEvent;
    import org.osflash.signals.Signal;

    public class ErrorDialogMediator extends Mediator 
    {

        [Inject]
        public var view:ErrorDialogView;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var errorVO:ErrorVO;
        [Inject]
        public var mainContext:MainContext;
        private var buttonURL:String = "";
        private var buttonTarget:String = "";
        private var localText:LocalText;


        override public function onRegister():void
        {
            this.localText = (LocalTextProxy.localText as LocalText);
            this.view.x = ((760 - this.view.width) * 0.5);
            this.view.y = ((435 - this.view.height) * 0.5);
            this.view.button.addEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.setupWithErrorVO(this.errorVO);
        }

        private function onButtonClick(event:MouseEvent):void
        {
            if (this.buttonURL == "")
            {
                Signal(this.signalBus.closeView).dispatch(this.view);
            }
            else
            {
                this.mainContext.handleJavascriptCall(this.buttonURL);
            };
        }

        public function setupWithErrorVO(errorVO:ErrorVO):void
        {
            this.localText.setText(this.view.messageField, errorVO.errorMessage);
            var buttonText:String = ((errorVO.buttonText != "") ? errorVO.buttonText : this.localizationManager.getLocalizedString("w.app.dialog.error.button.ok"));
            this.localText.setText(this.view.buttonField, buttonText);
            if (errorVO.buttonURL != "")
            {
                this.buttonURL = errorVO.buttonURL;
            };
            if (errorVO.buttonTarget != "")
            {
                this.buttonTarget = errorVO.buttonTarget;
            };
            this.view.errorCodeField.text = errorVO.errorCode.toString();
        }


    }
}//package com.clubpenguin.main.mediator.dialogs
