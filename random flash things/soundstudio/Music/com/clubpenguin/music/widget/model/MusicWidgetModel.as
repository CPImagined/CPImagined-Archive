//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.model
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.util.Log;
    import flash.external.ExternalInterface;

    public class MusicWidgetModel extends Actor 
    {

        private static const AVATAR_IMAGE_URL_LIVE_DOMAIN:String = "/avatar/";//"http://cdn.avatar.clubpenguin.com/"
        private static const AVATAR_IMAGE_URL_STAGE_DOMAIN:String = "http://stage.cdnseed.avatar.clubpenguin.com/";
        private static const AVATAR_IMAGE_URL_QA_DOMAIN:String = "http://dcefriendsweb01.sandbox.avatar.clubpenguin.com/";
        private static const AVATAR_IMAGE_URL_DEV_DOMAIN:String = "http://dev06web01.avatar.online.disney.com/";
        public static const NOW_PLAYING_TOKEN:String = "w.app.music.widget.nowplaying";
        public static const WHOS_NEXT_TOKEN:String = "w.app.music.widget.upnext";
        public static const QUEUE_POSITION_TOKEN:String = "w.app.music.widget.queueposition";
        public static const NO_TRACKS_SHARED_TOKEN:String = "w.app.music.widget.notracksshared";
        public static const MAIN_AVATAR_DIMENSIONS:int = 60;
        public static const URL_AVATAR_DIMENSIONS:int = 88;
        public static const QUEUED_AVATAR_DIMENSIONS:int = 20;
        public static const MAX_QUEUED_TRACKS:Number = 3;

        private var _numSharedTracks:int;
        private var _overlayCount:int;
        private var _sharedTracksQueue:Array;
        private var _collapsed:Boolean = true;
        private var _dragging:Boolean = false;
        private var _localPlayerIgnoreList:Array;
        private var _myQueuePosition:int;
        private var _active:Boolean = false;
        private var _visible:Boolean = true;
        private var _avatar_image_url_domain:String;

        public function MusicWidgetModel()
        {
            this._overlayCount = 0;
        }

        public function set collapsed(bool:Boolean):void
        {
            Log.debug(("bool: " + bool));
            this._collapsed = bool;
        }

        public function get collapsed():Boolean
        {
            return (this._collapsed);
        }

        public function set active(bool:Boolean):void
        {
            this._active = bool;
        }

        public function get active():Boolean
        {
            return (this._active);
        }

        public function set visible(bool:Boolean):void
        {
            this._visible = bool;
        }

        public function get visible():Boolean
        {
            return (this._visible);
        }

        public function set dragging(bool:Boolean):void
        {
            this._dragging = bool;
        }

        public function get dragging():Boolean
        {
            return (this._dragging);
        }

        public function get overlayCount():int
        {
            return (this._overlayCount);
        }

        public function set overlayCount(value:int):void
        {
            this._overlayCount = value;
            if (this._overlayCount < 1)
            {
                this._overlayCount = 0;
            };
        }

        public function set localPlayerIgnoreList(list:Array):void
        {
            this._localPlayerIgnoreList = list;
        }

        public function get localPlayerIgnoreList():Array
        {
            return ((this._localPlayerIgnoreList) ? this._localPlayerIgnoreList : new Array());
        }

        public function isPlayerIgnored(playerID:int):Boolean
        {
            var i:int;
            while (i < this.localPlayerIgnoreList.length)
            {
                if (int(this.localPlayerIgnoreList[i].player_id) == playerID)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function set numberOfSharedTracks(numSharedTracks:int):void
        {
            this._numSharedTracks = numSharedTracks;
        }

        public function get numberOfSharedTracks():int
        {
            return (this._numSharedTracks);
        }

        public function get currentSharedTrack():SharedTrackDataVO
        {
            Log.debug("");
            return ((this.sharedTracksQueue) ? this.sharedTracksQueue[0] : null);
        }

        public function resetSharedTracksQueue():void
        {
            this._sharedTracksQueue = new Array();
        }

        public function addToSharedTracksQueue(trackDataVO:SharedTrackDataVO):void
        {
            if (!this._sharedTracksQueue)
            {
                this.resetSharedTracksQueue();
            };
            this._sharedTracksQueue.push(trackDataVO);
        }

        public function get sharedTracksQueue():Array
        {
            return ((this._sharedTracksQueue) ? this._sharedTracksQueue : new Array());
        }

        public function set myQueuePosition(position:int):void
        {
            this._myQueuePosition = position;
        }

        public function get myQueuePosition():int
        {
            if (this._myQueuePosition == 0)
            {
                this._myQueuePosition = 1;
            };
            return (this._myQueuePosition);
        }

        public function get avatarImageURLDomain():String
        {
            Log.debug(("_avatar_image_url_domain " + this._avatar_image_url_domain));
            if (((this._avatar_image_url_domain == "") || (!(this._avatar_image_url_domain))))
            {
                this.setAvatarImageUrlDomain();
            };
            return (this._avatar_image_url_domain as String);
        }

        private function setAvatarImageUrlDomain():void
        {
            Log.debug("");
            var currentDomain:String = (ExternalInterface.call("window.location.href.toString") as String).split("/", 3)[2];
            var environment:String = currentDomain.split(".")[0];
            if (environment.search(new RegExp("^dev")) != -1)
            {
                this._avatar_image_url_domain = AVATAR_IMAGE_URL_DEV_DOMAIN;
            }
            else
            {
                if (environment.search(new RegExp("^qa")) != -1)
                {
                    this._avatar_image_url_domain = AVATAR_IMAGE_URL_QA_DOMAIN;
                }
                else
                {
                    if (environment.search(new RegExp("^stage")) != -1)
                    {
                        this._avatar_image_url_domain = AVATAR_IMAGE_URL_STAGE_DOMAIN;
                    }
                    else
                    {
                        this._avatar_image_url_domain = AVATAR_IMAGE_URL_LIVE_DOMAIN;
                    };
                };
            };
            Log.debug(("_avatar_image_url_domain " + this._avatar_image_url_domain));
        }


    }
}//package com.clubpenguin.music.widget.model
