//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import org.osflash.signals.Signal;

    public class StartRecordingCommand extends Command 
    {

        [Inject]
        public var event:MusicStudioEvent;
        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var appModel:IAppModel;
        [Inject]
        public var appSignalBus:SignalBus;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var musicPlayer:IMusicPlayer;


        override public function execute():void
        {
            Log.debug("");
            var isMember:Boolean = this.appModel.isMember();
            if (!isMember)
            {
                this.showNotAMemberOOpsMessage();
                this.model.setRecordingStatus(MusicStudioRecordingStatusEnum.OFF);
            }
            else
            {
                this.startRecording();
            };
        }

        private function showNotAMemberOOpsMessage():void
        {
            Log.debug("Not a member");
            this.tracker.trackGameAction("soundstudio", "oops_free_record", false, null, false, null);
            var oopsMessageFilePath:String = "membreship/soundstudio_oops.swf";
            var messageUrl:String = (this.appModel.getEnvironmentData().globalContentPath + oopsMessageFilePath);
            var data:Object = new Object();
            data.oopsTag = "oops_gold_berry_machine";
            var membershipPrompt:Signal = this.appModel.getAVMBridge().getShowMembershipPrompt();
            membershipPrompt.dispatch(messageUrl, data);
        }

        private function startRecording():void
        {
            Log.debug("");
            this.tracker.trackGameAction("soundstudio", "game_record", false, null, false, null);
            this.model.setRecordingStatus(MusicStudioRecordingStatusEnum.ON);
            commandMap.execute(RecordMusicPulseCommand, this.event);
            dispatch(new MusicStudioEvent(MusicStudioEvent.START_RECORDING_SUCCESS));
            this.musicPlayer.unmute();
            this.musicPlayer.resetLoops();
        }


    }
}//package com.clubpenguin.music.game.controller
