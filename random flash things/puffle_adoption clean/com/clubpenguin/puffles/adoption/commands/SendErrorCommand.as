//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import com.clubpenguin.lib.vo.ErrorVO;
    import org.osflash.signals.Signal;

    public class SendErrorCommand extends SignalCommand 
    {

        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var errorCodeID:uint;


        override public function execute():void
        {
            var errorCodeEnum:ErrorCodeEnum = ErrorCodeEnum.getTypeByErrorCode(this.errorCodeID);
            var errorCode:int = errorCodeEnum.getId();
            var errorMessage:String = this.localizationManager.getLocalizedString(errorCodeEnum.errorMessageTag);
            var buttonURL:String = errorCodeEnum.buttonURLTag;
            var buttonText:String = this.localizationManager.getLocalizedString(errorCodeEnum.buttonTextTag);
            var buttonTarget:String = errorCodeEnum.target;
            var errorVO:ErrorVO = new ErrorVO(errorMessage, errorCode, buttonURL, buttonText, buttonTarget);
            Signal(this.signalBus.showError).dispatch(errorVO);
        }


    }
}//package com.clubpenguin.puffles.adoption.commands
