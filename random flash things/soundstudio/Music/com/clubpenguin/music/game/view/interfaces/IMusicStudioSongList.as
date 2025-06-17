//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.interfaces
{
    import __AS3__.vec.Vector;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;

    public interface IMusicStudioSongList 
    {

        function songPlayBackUpdate(_arg_1:Vector.<SongDetailsVO>):void;
        function updateSongLikes(_arg_1:Vector.<SongDetailsVO>):void;
        function updateSharedSongs(_arg_1:Vector.<SongDetailsVO>):void;

    }
}//package com.clubpenguin.music.game.view.interfaces
