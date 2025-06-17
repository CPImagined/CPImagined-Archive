//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.lib.vo.IPlayerVO;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import org.osflash.signals.Signal;

    public interface IAppModel 
    {

        function getPathsVO():PathsVO;
        function getCardsCache():Array;
        function set cardsCache(_arg_1:Array):void;
        function getEnvironmentData():EnvironmentDataVO;
        function getLanguage():String;
        function getUsername():String;
        function getNickname():String;
        function getPlayerID():int;
        function getNewspaperPath():String;
        function getBasePath():String;
        function getClientPath():String;
        function isSafeMode():Boolean;
        function isMember():Boolean;
        function getCoins():int;
        function getLocalPlayerVO():IPlayerVO;
        function getCurrentWorldData():Object;
        function getOverrideBlockAllNotifications():Boolean;
        function setOverrideBlockAllNotifications(_arg_1:Boolean):void;
        function createAVMBridge():void;
        function getAVMBridge():IAVMBridgeService;
        function connectAVMBridge():void;
        function releaseAVMBridge():void;
        function getBuildParam():String;
        function getRoomUpdated():Signal;
        function getPlayerColors():Object;
        function setCurrentRoomId(_arg_1:int):void;
        function getCurrentRoomId():int;
        function getPlayerCount():int;
        function setMyPlayerMembership(_arg_1:Boolean):void;
        function setMyPlayerMembershipEnum(_arg_1:int):void;

    }
}//package com.clubpenguin.lib.module
