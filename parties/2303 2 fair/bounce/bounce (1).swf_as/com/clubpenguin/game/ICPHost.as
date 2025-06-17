package com.clubpenguin.game{
    import com.disney.coupler.ICouplerHost;
    import com.clubpenguin.lib.vo.IPlayerVO;
    import com.clubpenguin.lib.vo.IEndGameVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.MPGameVO;

    public interface ICPHost extends ICouplerHost {

        function getLocale():int;
        function getPlayerVO():IPlayerVO;
        function showEndGame(_arg_1:IEndGameVO):void;
        function getBasePath():String;
        function getBaseConfigPath():String;
        function showMembershipPrompt(_arg_1:String, _arg_2:String=null):void;
        function isMusicMuted():Boolean;
        function stampEarned(_arg_1:int, _arg_2:Boolean=false):void;
        function isStampEarned(_arg_1:int):Boolean;
        function levelComplete(_arg_1:int):void;
        function levelStart(_arg_1:int):void;
        function requestFPS(_arg_1:int):Boolean;
        function getPlayerColor():int;
        function purchaseItem(_arg_1:int):void;
        function getDoesPlayerOwnItem(_arg_1:int):Signal;
        function playMusic(_arg_1:int):void;
        function getGameStartParams():Object;
        function launchMPGame(_arg_1:MPGameVO):void;

    }
}//package com.clubpenguin.game
