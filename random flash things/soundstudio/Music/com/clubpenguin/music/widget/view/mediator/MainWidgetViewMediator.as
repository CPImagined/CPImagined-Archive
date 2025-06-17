//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.view.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.view.IMusicModuleContextView;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.services.socket.music.IMusicLikesService;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.music.widget.view.component.MainWidgetView;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.music.widget.model.SharedTrackDataVO;
    import flash.utils.setTimeout;
    import com.clubpenguin.music.resources.song.SongRecorded;

    public class MainWidgetViewMediator extends Mediator 
    {

        [Inject]
        public var model:MusicWidgetModel;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var _localizationManager:ILocalizationManager;
        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var musicModuleContextView:IMusicModuleContextView;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var likesService:IMusicLikesService;
        [Inject]
        public var tracker:Tracker;
        private var wasMyRequest:Boolean = false;


        public function get view():MainWidgetView
        {
            return (viewComponent as MainWidgetView);
        }

        override public function onRegister():void
        {
            super.onRegister();
            Log.debug("");
            addContextListener(MusicWidgetEvent.WIDGET_ASSETS_LOADED, this.onWidgetAssetsLoaded);
            addContextListener(MusicWidgetEvent.PLAY, this.onPlayMusicRequest);
            addContextListener(MusicWidgetEvent.UPDATE, this.onUpdateMainView);
            addContextListener(MusicWidgetEvent.SHOW, this.onShowWidget);
            addContextListener(MusicWidgetEvent.HIDE, this.onHideWidget);
            addContextListener(MusicWidgetEvent.LIKES_UPDATED, this.onLikesUpdated);
        }

        override public function onRemove():void
        {
            super.onRemove();
            Log.debug("");
            this.removeEventListeners();
            this.musicPlayer.stop();
        }

        private function addEventListeners():void
        {
            Log.debug("");
            if (!this.view)
            {
                return;
            };
            this.view.songlistButton.addEventListener(MouseEvent.CLICK, this.onInitializeSonglist);
            this.view.widgetView.addEventListener(MouseEvent.MOUSE_DOWN, this.startDraggingWidget, true);
            this.view.widgetView.addEventListener(MouseEvent.MOUSE_UP, this.stopDragging, true);
            this.view.addEventListener(MusicWidgetEvent.EXPAND, this.onWidgetExpanded);
            this.view.addEventListener(MusicWidgetEvent.COLLAPSE, this.onWidgetCollapsed);
            this.view.addEventListener(MusicWidgetEvent.COLLAPSE, this.onWidgetCollapsed);
            this.likesService.likesCount.add(this.onLikesReceived);
        }

        private function removeEventListeners():void
        {
            Log.debug("");
            if (!this.view)
            {
                return;
            };
            if (this.model.active)
            {
                this.view.toggleButton.removeEventListener(MouseEvent.MOUSE_UP, this.handleToggleButtonClicked);
            };
            this.view.songlistButton.removeEventListener(MouseEvent.CLICK, this.onInitializeSonglist);
            this.view.widgetView.removeEventListener(MouseEvent.MOUSE_DOWN, this.startDraggingWidget, true);
            this.view.widgetView.removeEventListener(MouseEvent.MOUSE_UP, this.stopDragging, true);
            this.view.removeEventListener(MusicWidgetEvent.EXPAND, this.onWidgetExpanded);
            this.view.removeEventListener(MusicWidgetEvent.COLLAPSE, this.onWidgetCollapsed);
            this.likesService.likesCount.remove(this.onLikesReceived);
        }

        protected function onLikesButtonRemoved(event:Event):void
        {
            this.view.likesPanelButton.removeEventListener(MouseEvent.CLICK, this.onLikesButtonClicked);
            this.view.likesPanelButton.removeEventListener(Event.REMOVED_FROM_STAGE, this.onLikesButtonRemoved);
        }

        private function onWidgetAssetsLoaded(e:*):void
        {
            Log.debug("");
            dispatch(new MusicWidgetEvent(MusicWidgetEvent.GET_BROADCASTS));
            this.addEventListeners();
            this.view.init();
            this.view.localize(this._localizationManager);
            this.checkUpdateWidgetActiveState();
        }

        private function onShowWidget(e:*):void
        {
            this.model.visible = true;
            this.view.show();
        }

        private function onHideWidget(e:*):void
        {
            Log.debug("");
            this.model.visible = false;
            this.removeEventListeners();
            this.view.hide();
        }

        private function checkUpdateWidgetActiveState():void
        {
            Log.debug(("model.numberOfSharedTracks " + this.model.numberOfSharedTracks));
            if (((this.model.numberOfSharedTracks <= 0) || (this.model.isPlayerIgnored(this.model.currentSharedTrack.playerID))))
            {
                Log.debug("The widget is not active");
                this.model.active = false;
                this.view.setWidgetToInactiveState();
                this.bridge.send(new AVMBridgeMessage(AVMBridgeMessage.MSG_UNMUTE_ROOM_MUSIC));
                return;
            };
            this.model.active = true;
            this.view.setWidgetToActiveState();
            var avatarURL:String = (((this.model.avatarImageURLDomain + this.model.currentSharedTrack.playerSwid) + "/cp?size=") + MusicWidgetModel.URL_AVATAR_DIMENSIONS);
            this.view.currentTrackPenguinInfo(String(this.model.currentSharedTrack.playerNickname), avatarURL);
            if (this.view.toggleButton)
            {
                this.view.toggleButton.addEventListener(MouseEvent.MOUSE_UP, this.handleToggleButtonClicked);
            };
            if (this.model.collapsed)
            {
                this.configureCollapsedWidget();
            }
            else
            {
                this.configureExpandedWidget();
            };
            this.view.initializeLikesButton();
            this.configureLikesPanel();
        }

        private function onUpdateMainView(e:*):void
        {
            Log.debug("");
            this.checkUpdateWidgetActiveState();
        }

        private function onInitializeSonglist(e:MouseEvent):void
        {
            if (this.model.dragging)
            {
                return;
            };
            Log.debug("");
            dispatch(new MusicWidgetEvent(MusicWidgetEvent.SHOW_MYSONGLIST));
        }

        private function onLikesUpdated(e:*):void
        {
            this.configureLikesPanel();
        }

        private function onLikesButtonClicked(e:MouseEvent):void
        {
            this.wasMyRequest = true;
            Log.debug("");
            Log.debug(("Show notification bubble model.currentSharedTrack.canLikeSong " + this.model.currentSharedTrack.canLikeSong));
            this.view.showNotificationBubble();
            if (this.model.currentSharedTrack.canLikeSong)
            {
                dispatch(new MusicWidgetEvent(MusicWidgetEvent.LIKE_SONG));
                this.model.currentSharedTrack.canLikeSong = false;
                this.view.updateLikesPanel(this.model.currentSharedTrack.likeCount, this.model.currentSharedTrack.canLikeSong);
            };
        }

        private function onLikesReceived(response:Object):void
        {
            Log.debug(("" + response));
            var count:int = parseInt(response.toString());
            Log.debug(("model.currentSharedTrack " + this.model.currentSharedTrack));
            if (this.model.currentSharedTrack)
            {
                this.model.currentSharedTrack.setLikesCount(count);
                if (this.wasMyRequest)
                {
                    this.model.currentSharedTrack.canLikeSong = false;
                };
                dispatch(new MusicWidgetEvent(MusicWidgetEvent.LIKES_UPDATED));
            };
        }

        private function handleToggleButtonClicked(e:MouseEvent):void
        {
            if (this.model.dragging)
            {
                return;
            };
            if (this.model.collapsed)
            {
                this.view.setToExpandedView();
            }
            else
            {
                this.view.setToCollapsedView();
            };
            this.model.collapsed = (!(this.model.collapsed));
        }

        private function onWidgetExpanded(e:*):void
        {
            Log.debug("");
            this.configureExpandedWidget();
        }

        private function onWidgetCollapsed(e:*):void
        {
            Log.debug("");
            this.configureCollapsedWidget();
        }

        private function configureCollapsedWidget():void
        {
            if (this.view.isQueueExpanded)
            {
                this.view.setToCollapsedView();
                return;
            };
            if (this.view.toggleButton)
            {
                this.view.toggleButton.addEventListener(MouseEvent.MOUSE_UP, this.handleToggleButtonClicked);
            };
        }

        private function configureExpandedWidget():void
        {
            var sharedTrackVO:SharedTrackDataVO;
            var avatarURL:String;
            if (this.view.isQueueCollapsed)
            {
                this.view.setToExpandedView();
                return;
            };
            this.view.localizeExpandedView();
            this.view.playersPositionInQueueLabel = this.model.myQueuePosition;
            var sharedTracksQueueIndex:int = 1;
            var queuePositionsConfigured:int = 1;
            while (((this.model.sharedTracksQueue) && (queuePositionsConfigured <= MusicWidgetModel.MAX_QUEUED_TRACKS)))
            {
                if (queuePositionsConfigured >= this.model.sharedTracksQueue.length)
                {
                    this.view.setPenguinInQueue(queuePositionsConfigured, "", null);
                    queuePositionsConfigured++;
                }
                else
                {
                    sharedTrackVO = this.model.sharedTracksQueue[sharedTracksQueueIndex];
                    sharedTracksQueueIndex++;
                    if (this.model.isPlayerIgnored(sharedTrackVO.playerID))
                    {
                        Log.debug("this is an ignored player");
                        this.view.setPenguinInQueue(queuePositionsConfigured, "", null);
                    }
                    else
                    {
                        avatarURL = ((((this.model.avatarImageURLDomain + sharedTrackVO.playerSwid) + "/cp?size=") + MusicWidgetModel.URL_AVATAR_DIMENSIONS) + "&language=en&photo=true&bypassPlayerSettingCache=false");
                        this.view.setPenguinInQueue(queuePositionsConfigured, avatarURL, sharedTrackVO.playerNickname);
                        queuePositionsConfigured++;
                    };
                };
            };
            if (this.view.toggleButton)
            {
                this.view.toggleButton.addEventListener(MouseEvent.MOUSE_UP, this.handleToggleButtonClicked);
            };
        }

        private function configureLikesPanel():void
        {
            if ((((this.musicModuleContextView.isMusicStudioOpen) || (this.musicModuleContextView.isMusicMySongListOpen)) || (!(this.model.active))))
            {
                return;
            };
            if (!this.view.likesPanelView)
            {
                this.view.setWidgetToActiveState();
            };
            this.view.likesPanelButton.addEventListener(MouseEvent.CLICK, this.onLikesButtonClicked);
            this.view.likesPanelButton.addEventListener(Event.REMOVED_FROM_STAGE, this.onLikesButtonRemoved);
            if (this.model.currentSharedTrack.canLikeSong)
            {
                this.view.likesPanelButton.buttonMode = true;
            }
            else
            {
                this.view.likesPanelButton.buttonMode = false;
            };
            this.view.updateLikesPanel(this.model.currentSharedTrack.likeCount, this.model.currentSharedTrack.canLikeSong);
        }

        private function startDraggingWidget(e:MouseEvent):void
        {
            this.view.widgetView.startDrag();
            setTimeout(this.setStartWidgetDragging, 200);
        }

        private function stopDragging(e:MouseEvent):void
        {
            this.view.widgetView.stopDrag();
            setTimeout(this.setStopWidgetDragging, 200);
        }

        private function setStartWidgetDragging():void
        {
            this.model.dragging = true;
        }

        private function setStopWidgetDragging():void
        {
            this.model.dragging = false;
        }

        private function onPlayMusicRequest(e:*):void
        {
            Log.debug("");
            this.wasMyRequest = false;
            if ((((this.model.isPlayerIgnored(this.model.currentSharedTrack.playerID)) || (this.musicModuleContextView.isMusicStudioOpen)) || (this.musicModuleContextView.isMusicMySongListOpen)))
            {
                Log.debug("setWidgetToInactiveState");
                this.view.setWidgetToInactiveState();
                return;
            };
            this.checkUpdateWidgetActiveState();
            if (!this.model.currentSharedTrack)
            {
                return;
            };
            this.musicPlayer.loadSong(new SongRecorded(this.model.currentSharedTrack.songID, this.model.currentSharedTrack.playerID));
            this.tracker.trackGameAction("soundstudio", "game_listen", false, null, false, {"message":this.model.currentSharedTrack.playerID.toString()});
        }


    }
}//package com.clubpenguin.music.widget.view.mediator
