//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.vo.ComplexPromptVO;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.services.notifications.INotificationService;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.main.dialogboxes.ComplexPromptEnum;
    import org.robotlegs.core.IMediatorMap;
    import flash.display.MovieClip;
    import com.clubpenguin.main.overlays.vo.ComplexPromptOverlayVO;
    import org.osflash.signals.Signal;

    public class ShowComplexPromptCommand extends SignalCommand 
    {

        [Inject]
        public var complexPromptVO:ComplexPromptVO;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var notificationService:INotificationService;
        [Inject]
        public var _mainContext:MainContext;


        override public function execute():void
        {
            var complexPromptEnum:ComplexPromptEnum = ComplexPromptEnum.getComplexPrompt(this.complexPromptVO.style);
            if (complexPromptEnum == null)
            {
                return;
            };
            var mediatorMap:IMediatorMap = this._mainContext.getMediatorMap();
            var viewClass:Class = complexPromptEnum.viewClass;
            var mediatorClass:Class = complexPromptEnum.mediatorClass;
            injector.mapValue(ComplexPromptVO, this.complexPromptVO);
            mediatorMap.mapView(viewClass, mediatorClass);
            var view:MovieClip = new (viewClass)();
            var complexPromptOverlayVO:ComplexPromptOverlayVO = new ComplexPromptOverlayVO(view);
            Signal(this.signalBus.showOverlay).dispatch(complexPromptOverlayVO);
            this.notificationService.stop();
        }


    }
}//package com.clubpenguin.main.command
