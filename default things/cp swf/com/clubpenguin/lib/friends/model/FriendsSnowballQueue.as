//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.model
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.lib.friends.FriendsSignalBus;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.main.model.MainModel;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import org.osflash.signals.Signal;

    public class FriendsSnowballQueue extends Actor 
    {

        private const QUEUE_TIME:Number = 30000;
        private const QUEUE_SIZE:int = 20;

        [Inject]
        public var signalBus:IAppSignalBus;
        [Inject]
        public var friendsSignalBus:FriendsSignalBus;
        [Inject]
        public var moduleModel:ModuleModel;
        private var _mainModel:MainModel;
        private var _swids:Array;
        private var _timer:Timer;

        public function FriendsSnowballQueue(mainModel:MainModel)
        {
            this._mainModel = mainModel;
            this._mainModel.onEnteredWorld.addOnce(this.onEnteredWorld);
            this._swids = [];
        }

        private function onEnteredWorld():void
        {
            if (this._swids.length > 0)
            {
                this.setupTimer();
            };
        }

        public function push(swid:String):void
        {
            if (((this._swids.length == 0) && (this._mainModel.loginRoomComplete)))
            {
                this.setupTimer();
            };
            if (this._swids.indexOf(swid) == -1)
            {
                if (this._swids.length < this.QUEUE_SIZE)
                {
                    this._swids.push(swid);
                };
            };
        }

        private function setupTimer():void
        {
            if (this._timer)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            };
            this._timer = new Timer(this.QUEUE_TIME, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._timer.start();
        }

        private function onTimerComplete(event:TimerEvent):void
        {
            var moduleVO:ModuleVO;
            if (!this.moduleModel.isModuleOpen(ModuleFilenamesEnum.SNOWBALL))
            {
                moduleVO = new ModuleVO();
                moduleVO.moduleName = ModuleFilenamesEnum.SNOWBALL.key;
                moduleVO.moduleData = {"swids":this._swids};
                moduleVO.hideLoadingDialog = true;
                moduleVO.modalBackgroundEnabled = false;
                Signal(this.signalBus.getLoadModule()).dispatch(moduleVO);
                this._swids = [];
            }
            else
            {
                this.setupTimer();
            };
        }


    }
}//package com.clubpenguin.lib.friends.model
