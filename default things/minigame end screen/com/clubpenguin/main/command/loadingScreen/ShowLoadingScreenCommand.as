//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command.loadingScreen
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.LoadingScreenModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.overlays.vo.OverlayVO;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.main.view.ui.LoadingScreenView;
    import org.osflash.signals.Signal;

    public class ShowLoadingScreenCommand extends SignalCommand 
    {

        [Inject]
        public var loadingScreenModel:LoadingScreenModel;
        [Inject]
        public var loadingText:String;
        [Inject]
        public var signalBus:SignalBus;


        override public function execute():void
        {
            var loadingScreenOverlayVO:OverlayVO;
            Log.debug("\tShowLoadingScreenCommand.execute()");
            if (!this.loadingScreenModel.isShowing)
            {
                loadingScreenOverlayVO = new OverlayVO();
                loadingScreenOverlayVO.object = new LoadingScreenView();
                loadingScreenOverlayVO.id = LoadingScreenModel.LOADING_SCREEN_NAME;
                Signal(this.signalBus.showOverlay).dispatch(loadingScreenOverlayVO);
                Log.debug(("\t\t-loadingText: " + this.loadingText));
                this.loadingScreenModel.show(this.loadingText);
            };
        }


    }
}//package com.clubpenguin.main.command.loadingScreen
