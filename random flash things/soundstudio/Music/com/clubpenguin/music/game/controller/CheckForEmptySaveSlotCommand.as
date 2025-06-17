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
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import org.osflash.signals.Signal;
    import flash.utils.setTimeout;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.mysonglist.MySongList;

    public class CheckForEmptySaveSlotCommand extends Command 
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
        private var hasEmptySaveSlot:Boolean;


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
                this.musicService.mySongsSignal.add(this.onMySongsResponseHandler);
                this.musicService.requestMySongs();
                commandMap.detain(this);
            };
        }

        private function showNotAMemberOOpsMessage():void
        {
            Log.debug("Not a member");
            this.tracker.trackGameAction("soundstudio", "oops_free_record", false, null, false, null);
            var oopsMessageFilePath:String = "membership/soundstudio_oops.swf";
            var messageUrl:String = (this.appModel.getEnvironmentData().globalContentPath + oopsMessageFilePath);
            var data:Object = new Object();
            data.oopsTag = "oops_gold_berry_machine";
            var membershipPrompt:Signal = this.appModel.getAVMBridge().getShowMembershipPrompt();
            membershipPrompt.dispatch(messageUrl, data);
        }

        private function onMySongsResponseHandler(response:String):void
        {
            Log.debug((" response " + response));
            Log.debug((' response.split(",").length ' + response.split(",").length));
            Log.debug((" response.length " + response.length));
            this.musicService.mySongsSignal.remove(this.onMySongsResponseHandler);
            commandMap.release(this);
            this.hasEmptySaveSlot = Boolean(((response == "") || (response.split(",").length < this.model.getMaxNumberOfSaveSlots())));
            if (!this.hasEmptySaveSlot)
            {
                setTimeout(this.promptUserToDeleteSongBeforeContinuing, 1000);
            };
            dispatch(new MusicStudioEvent(MusicStudioEvent.RECORD_PERMISSION_STATUS_UPDATE, this.hasEmptySaveSlot));
        }

        private function promptUserToDeleteSongBeforeContinuing():void
        {
            Log.debug("");
            (contextView as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicModuleEvent(MusicModuleEvent.SHOW_MYSONGLIST, MySongList.INIT_STUDIO_DELETE));
        }


    }
}//package com.clubpenguin.music.game.controller
