//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.view.component
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import com.clubpenguin.music.view.components.likes.LikesButton;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log;
    import flash.display.SimpleButton;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;

    public class MainWidgetView extends Sprite 
    {

        private static const ACTIVE_STATE_LABEL:String = "active";
        private static const INACTIVE_STATE_LABEL:String = "inactive";
        private static const EXPANDED_STATE_LABEL:String = "expanded";
        private static const COLLAPSED_STATE_LABEL:String = "collapsed";
        private static const EXPAND_ANIMATION_LABEL:String = "animExpand";
        private static const COLLAPSE_ANIMATION_LABEL:String = "animCollapse";

        protected var skin:MovieClip;
        protected var likes:LikesButton;
        private var _localizationManager:ILocalizationManager;

        public function MainWidgetView(skin:MovieClip)
        {
            this.skin = skin;
            addChild(skin);
        }

        public function init():void
        {
            this.setWidgetToInactiveState();
            this.dragAreaView.useHandCursor = false;
        }

        public function show():void
        {
            visible = true;
        }

        public function hide():void
        {
            Log.debug("");
            visible = false;
        }

        public function localize(localizationManager:ILocalizationManager):void
        {
            this._localizationManager = localizationManager;
        }

        public function setWidgetToInactiveState():void
        {
            Log.debug("");
            this.widgetView.gotoAndStop(INACTIVE_STATE_LABEL);
            this.dragAreaView.useHandCursor = false;
        }

        public function setWidgetToActiveState():void
        {
            Log.debug("");
            this.widgetView.gotoAndStop(ACTIVE_STATE_LABEL);
            this.dragAreaView.useHandCursor = false;
        }

        public function get widgetView():MovieClip
        {
            return (this.skin["widget_mc"] as MovieClip);
        }

        public function get dragAreaView():SimpleButton
        {
            return (this.skin["widget_mc"]["dragAreaBtn"] as SimpleButton);
        }

        public function get songlistButton():SimpleButton
        {
            return (this.skin["widget_mc"]["songlistBtn"] as SimpleButton);
        }

        public function get isQueueCollapsed():Boolean
        {
            return (this.expanderView.currentFrameLabel == COLLAPSED_STATE_LABEL);
        }

        public function get isQueueExpanded():Boolean
        {
            Log.debug(("expanderView.currentFrameLabel " + this.expanderView.currentFrameLabel));
            Log.debug(("expanderView.currentFrameLabel " + this.expanderView.currentFrame));
            return (this.expanderView.currentFrameLabel == EXPANDED_STATE_LABEL);
        }

        public function get expanderView():MovieClip
        {
            return (this.skin["widget_mc"]["queue_mc"] as MovieClip);
        }

        public function get toggleButton():SimpleButton
        {
            if (!this.skin["widget_mc"]["queue_mc"]["toggleBtn"])
            {
                return (null);
            };
            return (this.skin["widget_mc"]["queue_mc"]["toggleBtn"] as SimpleButton);
        }

        public function get likesPanelView():MovieClip
        {
            return (this.skin["widget_mc"]["likesPanel_mc"] as MovieClip);
        }

        public function get likesPanelButton():MovieClip
        {
            return (this.skin["widget_mc"]["likesPanel_mc"]["button"] as MovieClip);
        }

        public function get likesHeart():MovieClip
        {
            return (this.skin["widget_mc"]["likesPanel_mc"]["label"] as MovieClip);
        }

        public function currentTrackPenguinInfo(penguinName:String, avatarURL:String):void
        {
            this.skin["widget_mc"]["penguinName"].text = penguinName;
            if (!this._localizationManager)
            {
                return;
            };
            this.skin["widget_mc"]["nowPlayingLabel"].text = this._localizationManager.getLocalizedString(MusicWidgetModel.NOW_PLAYING_TOKEN);
            this.loadPlayerCardForPlayer(avatarURL, this.skin["widget_mc"]["avatarThumbMC"], MusicWidgetModel.MAIN_AVATAR_DIMENSIONS);
        }

        public function localizeExpandedView():void
        {
            if (((!(this.expanderView["whosNextLabel"])) || (!(this._localizationManager))))
            {
                return;
            };
            this.expanderView["whosNextLabel"].text = this._localizationManager.getLocalizedString(MusicWidgetModel.WHOS_NEXT_TOKEN);
        }

        public function setPenguinInQueue(position:Number, avatarURL:String, playerName:String):void
        {
            if (((!(this.skin["widget_mc"]["queue_mc"][("queue_" + position)])) || (!(this._localizationManager))))
            {
                return;
            };
            if (playerName == null)
            {
                this.skin["widget_mc"]["queue_mc"][("queue_" + position)].gotoAndStop(INACTIVE_STATE_LABEL);
                return;
            };
            this.skin["widget_mc"]["queue_mc"][("queue_" + position)].gotoAndStop(ACTIVE_STATE_LABEL);
            this.skin["widget_mc"]["queue_mc"][("queue_" + position)]["playerNameLabel"].text = playerName;
            this.loadPlayerCardForPlayer(avatarURL, this.skin["widget_mc"]["queue_mc"][("queue_" + position)]["avatarThumbMC"], MusicWidgetModel.QUEUED_AVATAR_DIMENSIONS);
        }

        private function loadPlayerCardForPlayer(avatarURL:String, containerMC:MovieClip, thumbSize:int):void
        {
            var url:String = avatarURL;
            Log.error(("avatarURL " + avatarURL));
            var avatarLoader:Loader = new Loader();
            avatarLoader.load(new URLRequest(url));
            containerMC.addChild(avatarLoader);
            avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void
            {
                containerMC.width = thumbSize;
                containerMC.height = thumbSize;
            });
            avatarLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onAvatarLoadError);
        }

        private function onAvatarLoadError(e:IOErrorEvent):void
        {
            Log.error("MainWidgetView.onAvatarLoadError(): Avatar failed to load");
        }

        public function set playersPositionInQueueLabel(queuePosition:Number):void
        {
            var formatedString:String;
            var defaultString:String;
            if (((!(this.skin["widget_mc"]["queue_mc"]["queuePositionLabel"])) || (!(this._localizationManager))))
            {
                return;
            };
            if (queuePosition <= -1)
            {
                formatedString = this._localizationManager.getLocalizedString(MusicWidgetModel.NO_TRACKS_SHARED_TOKEN);
            }
            else
            {
                defaultString = this._localizationManager.getLocalizedString(MusicWidgetModel.QUEUE_POSITION_TOKEN);
                formatedString = defaultString.split("%number%").join(String(queuePosition));
            };
            this.skin["widget_mc"]["queue_mc"]["queuePositionLabel"].text = formatedString;
        }

        public function setToCollapsedView():void
        {
            if (this.expanderView.currentFrameLabel == EXPANDED_STATE_LABEL)
            {
                this.expanderView.gotoAndPlay(COLLAPSE_ANIMATION_LABEL);
                this.expanderView.addEventListener(Event.ENTER_FRAME, this.trackCollapsedAnimation);
            }
            else
            {
                this.expanderView.gotoAndStop(COLLAPSED_STATE_LABEL);
            };
        }

        public function setToExpandedView():void
        {
            if (this.expanderView.currentFrameLabel == COLLAPSED_STATE_LABEL)
            {
                this.expanderView.gotoAndPlay(EXPAND_ANIMATION_LABEL);
                this.expanderView.addEventListener(Event.ENTER_FRAME, this.trackExpanderAnimation);
            }
            else
            {
                this.expanderView.gotoAndStop(EXPANDED_STATE_LABEL);
                return;
            };
        }

        private function trackExpanderAnimation(e:Event):void
        {
            if (e.target.currentFrameLabel == EXPANDED_STATE_LABEL)
            {
                e.target.stop();
                if (this.toggleButton != null)
                {
                    dispatchEvent(new MusicWidgetEvent(MusicWidgetEvent.EXPAND));
                    e.target.removeEventListener(Event.ENTER_FRAME, this.trackExpanderAnimation);
                };
            };
        }

        private function trackCollapsedAnimation(e:Event):void
        {
            if (e.target.currentFrameLabel == COLLAPSED_STATE_LABEL)
            {
                e.target.stop();
                if (this.toggleButton != null)
                {
                    dispatchEvent(new MusicWidgetEvent(MusicWidgetEvent.COLLAPSE));
                    e.target.removeEventListener(Event.ENTER_FRAME, this.trackCollapsedAnimation);
                };
            };
        }

        public function updateLikesPanel(likesCount:int, enabled:Boolean):void
        {
            if (!this.likes)
            {
                this.initializeLikesButton();
            };
            this.likes.enabled = enabled;
            this.likes.likesCount = likesCount;
        }

        public function showNotificationBubble():void
        {
            Log.debug("Show notification bubble");
            this.likes.showNotificationBubble();
        }

        public function initializeLikesButton():void
        {
            this.likes = new LikesButton(this.likesPanelView);
            this.likes.localize(this._localizationManager);
        }


    }
}//package com.clubpenguin.music.widget.view.component
