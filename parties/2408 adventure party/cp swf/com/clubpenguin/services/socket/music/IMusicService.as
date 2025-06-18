//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.music
{
    import org.osflash.signals.ISignal;

    public interface IMusicService 
    {

        function get songSignal():ISignal;
        function get mySongsSignal():ISignal;
        function get saveSongSignal():ISignal;
        function get deleteSongSignal():ISignal;
        function get shareSongSignal():ISignal;
        function get getSharedSongSignal():ISignal;
        function get broadcastMusicTracksSignal():ISignal;
        function get songLikesSignal():ISignal;
        function requestSongByID(_arg_1:int, _arg_2:int):void;
        function saveSong(_arg_1:String):void;
        function deleteSong(_arg_1:String):void;
        function shareSong(_arg_1:String, _arg_2:String):void;
        function getSongData(_arg_1:String):void;
        function requestMySongs():void;
        function requestSharedSongs():void;
        function requestSongLikes(_arg_1:int, _arg_2:int):void;
        function requestMyLikes():void;
        function requestBroadcastingMusicTracks():void;

    }
}//package com.clubpenguin.services.socket.music
