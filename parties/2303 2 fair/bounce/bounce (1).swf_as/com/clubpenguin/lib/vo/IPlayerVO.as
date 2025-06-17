package com.clubpenguin.lib.vo{
    import com.clubpenguin.lib.util.collection.ICollection;

    public interface IPlayerVO {

        function getNickname():String;
        function getPlayerId():int;
        function getPlayerSwid():String;
        function getIsMember():Boolean;
        function getMembershipEnum():int;
        function getIsEpfAgent():Boolean;
        function getCoins():int;
        function getPuffles():ICollection;
        function getChoseSafeChatWorld():Boolean;
        function getColorID():Number;
        function getRemainingHours():int;
        function getMaxGraceHours():int;
        function getConfirmationHash():String;
        function getLoginDataRaw():String;
        function getEmailAddress():String;

    }
}//package com.clubpenguin.lib.vo
