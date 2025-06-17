//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.context
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.mysonglist.view.component.SongListView;
    import com.clubpenguin.music.mysonglist.view.mediator.SongListViewMediator;
    import com.clubpenguin.music.mysonglist.controller.DeleteSongCommand;
    import com.clubpenguin.music.mysonglist.controller.CloseModuleCommand;
    import com.clubpenguin.music.mysonglist.controller.PlaySongCommand;
    import com.clubpenguin.music.mysonglist.controller.ShareSongCommand;
    import com.clubpenguin.music.mysonglist.controller.GetSongLikesCommand;
    import com.clubpenguin.music.mysonglist.controller.PauseSongCommand;
    import com.clubpenguin.music.mysonglist.controller.OpenStudioCommand;
    import com.clubpenguin.music.mysonglist.controller.CreateNewTrackCommand;
    import com.clubpenguin.music.mysonglist.controller.LoadMySongListCommand;

    public class MySongListContext extends BaseModuleContext 
    {

        private var mySongListModel:MySongListModel;
        private var _initData:String;

        public function MySongListContext(contextView:BaseModule, injector:IInjector, initData:String)
        {
            super(contextView, injector);
            this._initData = initData;
            this.setInitData();
        }

        override public function startup():void
        {
            Log.debug("");
            super.startup();
            this.mediateViews();
            this.mapCommands();
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(MySongListContext, this);
            this.mySongListModel = new MySongListModel();
            injector.injectInto(this.mySongListModel);
            injector.mapValue(MySongListModel, this.mySongListModel);
        }

        private function setInitData():void
        {
            this.mySongListModel.initData = this._initData;
        }

        private function mediateViews():void
        {
            mediatorMap.mapView(SongListView, SongListViewMediator, null, false);
        }

        private function mapCommands():void
        {
            signalCommandMap.mapSignal(this.mySongListModel.songDeletedSignal, DeleteSongCommand);
            signalCommandMap.mapSignal(this.mySongListModel.closeModuleSignal, CloseModuleCommand);
            signalCommandMap.mapSignal(this.mySongListModel.songPlayedSignal, PlaySongCommand);
            signalCommandMap.mapSignal(this.mySongListModel.songSharedSignal, ShareSongCommand);
            signalCommandMap.mapSignal(this.mySongListModel.getLikesSignal, GetSongLikesCommand);
            signalCommandMap.mapSignal(this.mySongListModel.songStopSignal, PauseSongCommand);
            signalCommandMap.mapSignal(this.mySongListModel.openStudioSignal, OpenStudioCommand);
            signalCommandMap.mapSignal(this.mySongListModel.createTrackSignal, CreateNewTrackCommand);
            commandMap.execute(LoadMySongListCommand);
        }


    }
}//package com.clubpenguin.music.mysonglist.context
