//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.interfaces
{
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import __AS3__.vec.Vector;

    public interface IMusicStudioPrompts 
    {

        function showSavePrompt(_arg_1:SongDetailsVO):void;
        function hideSavePrompt():void;
        function onSongSaveSuccess():void;
        function onSongSaveFail(_arg_1:String):void;
        function songPlayBackUpdate(_arg_1:Vector.<SongDetailsVO>):void;
        function updateNameValidation(_arg_1:Boolean):void;

    }
}//package com.clubpenguin.music.game.view.interfaces
