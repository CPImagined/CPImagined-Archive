//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.data
{
    import com.clubpenguin.game.timer.IGameTimer;
    import com.clubpenguin.lib.IDisposable;
    import com.clubpenguin.game.timer.IGameTimerClient;

    public class ProjectGlobals 
    {

        private static var $_DebugMode:Boolean = true;
        private static var $_gameTimer:IGameTimer;
        private static var $_dataStores:Array;
        private static var $_firstFunctionCalled:String;


        public static function setTimer(_timer:IGameTimer):void
        {
            $_gameTimer = _timer;
        }

        public static function dataStoreAdd(_storeID:String, _store:IDisposable):void
        {
            if ($_dataStores == null)
            {
                $_dataStores = new Array();
            };
            $_dataStores[_storeID] = _store;
        }

        public static function dataStoreCall(_storeID:String, _method:String):Function
        {
            var storeItem:IDisposable;
            if ($_dataStores == null)
            {
                $_dataStores = new Array();
            };
            storeItem = $_dataStores[_storeID];
            return (storeItem[_method]);
        }

        public static function dispose():void
        {
            $_gameTimer.dispose();
            disposeDataStores();
        }

        private static function disposeDataStores():void
        {
            var index:String;
            var currentStore:IDisposable;
            for (index in $_dataStores)
            {
                currentStore = $_dataStores[index];
                currentStore.dispose();
            };
            $_dataStores = null;
        }

        public static function registerToTimer(_timerClient:IGameTimerClient, _frequency:int, _modifier:Boolean=false, _canPause:Boolean=true):Boolean
        {
            if ($_gameTimer == null)
            {
            };
            return ($_gameTimer.register(_timerClient, _frequency, _modifier, _canPause));
        }

        public static function unregisterFromTimer(_timerClient:IGameTimerClient):Boolean
        {
            return ($_gameTimer.unregister(_timerClient));
        }

        public static function startGameTimer():void
        {
            $_gameTimer.start();
        }

        public static function stopGameTimer():void
        {
            $_gameTimer.stop();
        }

        public static function pauseGame(_bool:Boolean):void
        {
            $_gameTimer.pause(_bool);
        }

        public static function get debugMode():Boolean
        {
            return ($_DebugMode);
        }


    }
}//package com.clubpenguin.lib.data
