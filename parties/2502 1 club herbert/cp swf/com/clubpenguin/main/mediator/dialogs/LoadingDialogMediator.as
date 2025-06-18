//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator.dialogs
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.view.dialogs.LoadingDialogView;
    import com.clubpenguin.main.signal.SignalBus;

    public class LoadingDialogMediator extends Mediator 
    {

        [Inject]
        public var view:LoadingDialogView;
        [Inject]
        public var signalBus:SignalBus;


        override public function onRegister():void
        {
            this.signalBus.updateLoadingDialog.add(this.update);
        }

        override public function onRemove():void
        {
            this.signalBus.updateLoadingDialog.remove(this.update);
        }

        private function update(value:Number):void
        {
            this.view.loadingBar.progressBar.scaleX = (value / 100);
        }


    }
}//package com.clubpenguin.main.mediator.dialogs
