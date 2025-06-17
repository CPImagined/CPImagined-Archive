//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.player
{
    import com.clubpenguin.music.resources.song.SongRecorded;

    public interface IMusicPlayer 
    {

        function loadSong(_arg_1:SongRecorded):void;
        function appendStatus(_arg_1:String):void;
        function loadEmptySong(_arg_1:int):void;
        function play():void;
        function stop(_arg_1:Boolean=false):void;
        function mute():void;
        function unmute():void;
        function resetLoops():void;

    }
}//package com.clubpenguin.music.player
