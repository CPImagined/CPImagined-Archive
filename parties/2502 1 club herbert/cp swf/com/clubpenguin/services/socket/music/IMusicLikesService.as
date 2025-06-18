//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.music
{
    import org.osflash.signals.ISignal;

    public interface IMusicLikesService 
    {

        function get likesCount():ISignal;
        function get cannotLikeTrack():ISignal;
        function get checkCanLikeTrack():ISignal;
        function requestSendLike(_arg_1:int, _arg_2:int):void;
        function requestLikeCountBySongID(_arg_1:int, _arg_2:int):void;
        function requestCanLikeSong(_arg_1:int, _arg_2:int):void;

    }
}//package com.clubpenguin.services.socket.music
