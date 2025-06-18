//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services
{
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import org.osflash.signals.Signal;

    public interface IAVMBridgeService 
    {

        function connect(_arg_1:String):Boolean;
        function messageFromAS2(_arg_1:Object):void;
        function airTowerEvent(_arg_1:Object):void;
        function send(_arg_1:AVMBridgeMessage):void;
        function sendStringInChunks(_arg_1:String, _arg_2:String):void;
        function trackEvent(_arg_1:String):void;
        function sendServerCommand(_arg_1:String):void;
        function getEndGameScreenData():Signal;
        function getCreateMyPlayerVO():Signal;
        function getOpenModule():Signal;
        function getInitialized():Signal;
        function getUpdateCoins():Signal;
        function getShowMembershipPrompt():Signal;
        function getAS2Clicked():Signal;
        function getHideTriggers():Signal;
        function getShowTriggers():Signal;
        function getStampEarned():Signal;
        function getStartNotificationServices():Signal;
        function getStopNotificationServices():Signal;
        function getShowPrompt():Signal;
        function getClosePrompt():Signal;
        function getRoomLoaded():Signal;
        function getHideLikeWindow():Signal;
        function getShowLikeWindow():Signal;
        function getCloseLikeWindow():Signal;
        function getReceivedDoesPlayerOwnItem():Signal;
        function getAS2MouseReleased():Signal;
        function getAS2DataReceived():Signal;
        function getConsoleDebug():Signal;
        function getShowComplexPrompt():Signal;
        function getShowAssetPrompt():Signal;
        function getCloseAssetPrompt():Signal;
        function close():void;
        function getHideQuestUI():Signal;
        function getShowQuestUI():Signal;
        function getFocusPhraseChat():Signal;
        function getPartyInit():Signal;
        function getMapLegendAnimComplete():Signal;
        function isConnected():Boolean;
        function getShowPuffleTricksHUD():Signal;
        function getEnablePuffleTricksHUD():Signal;
        function getDisablePuffleTricksHUD():Signal;
        function getShowPuffleTreasureNotification():Signal;
        function getLocalPlayerIgnoreList():Signal;
        function getMuteMusicPlayer():Signal;
        function getUnmuteMusicPlayer():Signal;
        function getStartIglooMusicSignal():Signal;
        function getStopIglooMusicSignal():Signal;

    }
}//package com.clubpenguin.lib.services
