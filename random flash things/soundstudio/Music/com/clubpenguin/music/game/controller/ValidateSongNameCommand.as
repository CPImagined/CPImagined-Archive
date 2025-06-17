//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.game.service.INameValidationService;
    import com.clubpenguin.music.game.events.MusicStudioSongNameEvent;
    import com.clubpenguin.music.game.model.vo.SongNameValidationVO;

    public class ValidateSongNameCommand extends Command 
    {

        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var service:INameValidationService;
        [Inject]
        public var event:MusicStudioSongNameEvent;


        public function get songName():String
        {
            return (this.event.songNameValidationVO.songName);
        }

        override public function execute():void
        {
            var vo:SongNameValidationVO;
            var nameValid:int = this.model.getSongNameValidation(this.songName);
            if (nameValid != MusicStudioModel.SONG_NAME_NOT_VERIFIED)
            {
                vo = new SongNameValidationVO(this.songName, (nameValid == MusicStudioModel.SONG_NAME_VALID));
                this.sendResult(vo);
            }
            else
            {
                this.sendValidationRequest();
            };
        }

        private function sendValidationRequest():void
        {
            this.service.nameValidationResult.addOnce(this.onValidationResult);
            this.service.checkName(this.songName);
        }

        private function onValidationResult(result:SongNameValidationVO):void
        {
            this.sendResult(result);
        }

        private function sendResult(vo:SongNameValidationVO):void
        {
            this.model.setSongNameValidation(vo.songName, vo.isValid);
            dispatch(new MusicStudioSongNameEvent(MusicStudioSongNameEvent.SONG_NAME_VALIDATION_RESULT, vo));
        }


    }
}//package com.clubpenguin.music.game.controller
