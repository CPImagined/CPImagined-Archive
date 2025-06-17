//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service
{
    import com.clubpenguin.lib.services.AVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.managers.localization.LocalizationManager;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import com.clubpenguin.lib.vo.ErrorVO;

    public class ErrorService 
    {

        private var _bridge:AVMBridgeService;
        private var _mainModel:MainModel;
        private var _localizationManager:LocalizationManager;
        public var updateLoginFloodManager:Signal = new Signal();


        public function init(bridge:AVMBridgeService, mainModel:MainModel, localizationManager:LocalizationManager):void
        {
            this._bridge = bridge;
            this._mainModel = mainModel;
            this._localizationManager = localizationManager;
            this._bridge.showError.add(this.onResponded);
        }

        public function onResponded(errorObject:Object):void
        {
            var errorCodeEnum:ErrorCodeEnum;
            var errorMessageTag:String;
            var errorMessageText:String;
            var errorMessageButtonTag:String;
            var errorMessageButtonText:String;
            var errorMessageButtonURL:String;
            var errorMessageButtonTarget:String;
            var errorVO:ErrorVO;
            var errorMessageTextArgsArray:Array;
            if (ErrorCodeEnum.hasError(errorObject.errorCode))
            {
                errorCodeEnum = ErrorCodeEnum.getTypeByErrorCode(errorObject.errorCode);
                errorMessageTag = errorCodeEnum.errorMessageTag;
                if (((errorCodeEnum == ErrorCodeEnum.CONNECTION_LOST) || (errorCodeEnum == ErrorCodeEnum.SOCKET_LOST_CONNECTION)))
                {
                    this.updateLoginFloodManager.dispatch();
                };
                if (errorObject.errorMessageTextArgsArray)
                {
                    errorMessageTextArgsArray = (errorObject.errorMessageTextArgsArray as Array);
                    errorMessageTextArgsArray.unshift(errorMessageTag);
                    errorMessageText = this._localizationManager.getLocalizedString.apply(this, errorMessageTextArgsArray);
                }
                else
                {
                    errorMessageText = this._localizationManager.getLocalizedString(errorMessageTag);
                };
                errorMessageButtonTag = errorCodeEnum.buttonTextTag;
                errorMessageButtonText = this._localizationManager.getLocalizedString(errorMessageButtonTag);
                errorMessageButtonURL = ((errorCodeEnum.buttonURLTag != "") ? this._localizationManager.getLocalizedString(errorCodeEnum.buttonURLTag) : "");
                errorMessageButtonTarget = errorCodeEnum.target;
                errorVO = new ErrorVO(errorMessageText, (errorObject.errorCode as uint), errorMessageButtonURL, errorMessageButtonText, errorMessageButtonTarget);
                Signal(this._mainModel.signalBus.showError).dispatch(errorVO);
            };
        }


    }
}//package com.clubpenguin.main.service
