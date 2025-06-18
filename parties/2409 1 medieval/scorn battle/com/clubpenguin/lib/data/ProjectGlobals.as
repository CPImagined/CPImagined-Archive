package com.clubpenguin.lib.data{
    import com.clubpenguin.game.timer.IGameTimer;
    import com.clubpenguin.lib.IDisposable;
    import com.clubpenguin.game.timer.IGameTimerClient;

    public class ProjectGlobals {

        private static var $_DebugMode:Boolean = true;
        private static var $_gameTimer:IGameTimer;
        private static var $_dataStores:Array;
        private static var $_firstFunctionCalled:String;


        public static function setTimer(_arg_1:IGameTimer):void{
            trace(("Set Timer to " + _arg_1));
            $_gameTimer = _arg_1;
        }

        public static function dataStoreAdd(_arg_1:String, _arg_2:IDisposable):void{
            if ($_dataStores == null){
                $_dataStores = new Array();
            };
            $_dataStores[_arg_1] = _arg_2;
        }

        public static function dataStoreCall(_arg_1:String, _arg_2:String):Function{
            var _local_3:IDisposable;
            if ($_dataStores == null){
                $_dataStores = new Array();
            };
            _local_3 = $_dataStores[_arg_1];
            return (_local_3[_arg_2]);
        }

        public static function dispose():void{
            $_gameTimer.dispose();
            disposeDataStores();
        }

        private static function disposeDataStores():void{
            var _local_1:String;
            var _local_2:IDisposable;
            for (_local_1 in $_dataStores) {
                _local_2 = $_dataStores[_local_1];
                _local_2.dispose();
            };
            $_dataStores = null;
        }

        public static function registerToTimer(_arg_1:IGameTimerClient, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=true):Boolean{
            if ($_gameTimer == null){
                trace("[ProjectGlobals] Error: Timer not set");
            };
            return ($_gameTimer.register(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public static function unregisterFromTimer(_arg_1:IGameTimerClient):Boolean{
            return ($_gameTimer.unregister(_arg_1));
        }

        public static function startGameTimer():void{
            $_gameTimer.start();
        }

        public static function stopGameTimer():void{
            $_gameTimer.stop();
        }

        public static function pauseGame(_arg_1:Boolean):void{
            $_gameTimer.pause(_arg_1);
        }

        public static function get debugMode():Boolean{
            return ($_DebugMode);
        }


    }
}//package com.clubpenguin.lib.data
