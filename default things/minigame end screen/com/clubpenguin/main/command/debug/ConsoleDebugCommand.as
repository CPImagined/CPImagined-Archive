//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command.debug
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.events.SecurityErrorEvent;
    import flash.events.AsyncErrorEvent;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import com.clubpenguin.lib.vo.ErrorVO;
    import com.clubpenguin.lib.services.AVMBridgeService;
    import org.osflash.signals.Signal;

    public class ConsoleDebugCommand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var signalBus:IAppSignalBus;
        [Inject]
        public var consoleEvent:Object;
        [Inject]
        public var locMan:ILocalizationManager;


        override public function execute():void
        {
            var securityError:SecurityErrorEvent;
            var asyncError:AsyncErrorEvent;
            var errorEnum:ErrorCodeEnum;
            var msg:String;
            var errorVO:ErrorVO;
            var path:Array = contextView.stage.loaderInfo.url.toLowerCase().split("://");
            var domainName:Array = path[1].split(".");
            if ((((((domainName[0].indexOf("sandbox") == 0) || (domainName[1].indexOf("sandbox") == 0)) || (domainName[0].indexOf("qa") == 0)) || (domainName[0].indexOf("dev") == 0)) || (domainName[0].indexOf("stage") == 0)))
            {
                switch (this.consoleEvent.type)
                {
                    case "BridgeSecurityError":
                        securityError = new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR, false, false, "Test Error Message", 9999);
                        AVMBridgeService(this.bridge).onBridgeSecurityError(securityError);
                        break;
                    case "BridgeAsyncError":
                        asyncError = new AsyncErrorEvent(AsyncErrorEvent.ASYNC_ERROR);
                        asyncError.error = new Error("This is a test AsyncErrorEvent Message");
                        AVMBridgeService(this.bridge).onBridgeAsyncError(asyncError);
                        break;
                    case "BridgeArgumentError":
                        errorEnum = ErrorCodeEnum.getTypeByErrorCode(uint(this.consoleEvent.payload.errorNum));
                        if (errorEnum == null)
                        {
                            return;
                        };
                        msg = this.locMan.getLocalizedString(errorEnum.errorMessageTag);
                        errorVO = new ErrorVO(msg, this.consoleEvent.payload.errorNum);
                        Signal(this.signalBus.getShowError()).dispatch(errorVO);
                        break;
                };
            };
        }


    }
}//package com.clubpenguin.main.command.debug
