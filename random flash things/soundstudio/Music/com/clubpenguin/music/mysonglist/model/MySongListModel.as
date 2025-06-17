//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.model
{
    import org.robotlegs.mvcs.Actor;
    import __AS3__.vec.Vector;
    import org.osflash.signals.Signal;

    public class MySongListModel extends Actor 
    {

        public static const TOKEN_DELETE_HEADER1:String = "w.app.music.songlist.deleteheader1";
        public static const TOKEN_DELETE_HEADER2:String = "w.app.music.songlist.deleteheader2";
        public static const TOKEN_NOTRACK1:String = "w.app.music.songlist.notrack1";
        public static const TOKEN_NOTRACK2:String = "w.app.music.songlist.notrack2";
        public static const TOKEN_STARTSTUDIO:String = "w.app.music.songlist.startstudio";
        public static const TOKEN_NOTMEMBER:String = "w.app.music.songlist.notmember";
        public static const TOKEN_LOGO:String = "m.game.soundstudio.savedTracks";
        public static const TOKEN_SONG_EMPTY:String = "w.app.music.songlist.songempty";
        public static const TOKEN_SONG_LIKES:String = "w.app.music.songlist.songlikes";
        public static const TOKEN_SONG_DELETE:String = "w.app.music.songlist.songdelete";
        public static const TOKEN_SHARE_ON:String = "w.app.music.songlist.on";
        public static const TOKEN_SHARE_OFF:String = "w.app.music.songlist.off";
        public static const TOKEN_SHARE_SHARING:String = "w.app.music.songlist.sharing";
        public static const TOKEN_YES:String = "w.app.music.songlist.yes";
        public static const TOKEN_NO:String = "w.app.music.songlist.no";
        public static const TOKEN_SHARED_NONE1:String = "w.app.music.songlist.sharednone1";
        public static const TOKEN_SHARED_NONE2:String = "w.app.music.songlist.sharednone2";
        public static const TOKEN_SHARED_CLUB:String = "w.app.music.songlist.sharedclub";
        public static const TOKEN_SHARED_HEADER:String = "w.app.music.songlist.sharedheader";
        public static const MAX_SONGS:Number = 12;

        private var _songVOList:Vector.<SongDataVO>;
        private var _dataLoadedSignal:Signal;
        private var _songDeletedSignal:Signal;
        private var _songDeletedResponseSignal:Signal;
        private var _songSharedSignal:Signal;
        private var _songSharedResponseSignal:Signal;
        private var _songPlayedSignal:Signal;
        private var _songStopSignal:Signal;
        private var _closeModuleSignal:Signal;
        private var _getLikesSignal:Signal;
        private var _getLikesResponseSignal:Signal;
        private var _openStudioSignal:Signal;
        private var _createTrackSignal:Signal;
        private var _initData:String;
        private var _isMember:Boolean;
        public var language:String;

        public function MySongListModel()
        {
            this._dataLoadedSignal = new Signal();
            this._songDeletedSignal = new Signal(String);
            this._songSharedSignal = new Signal(String);
            this._songPlayedSignal = new Signal(String);
            this._songStopSignal = new Signal(String);
            this._closeModuleSignal = new Signal();
            this._openStudioSignal = new Signal();
            this._songDeletedResponseSignal = new Signal(String);
            this._songSharedResponseSignal = new Signal(String);
            this._getLikesSignal = new Signal(String);
            this._getLikesResponseSignal = new Signal(String);
            this._createTrackSignal = new Signal();
        }

        public function setSongVOs(songVOList:Vector.<SongDataVO>):void
        {
            this._songVOList = songVOList;
            this._dataLoadedSignal.dispatch();
        }

        public function get songVOList():Vector.<SongDataVO>
        {
            return (this._songVOList);
        }

        public function set initData(initData:String):void
        {
            this._initData = initData;
        }

        public function get initData():String
        {
            return (this._initData);
        }

        public function set isMember(isMember:Boolean):void
        {
            this._isMember = isMember;
        }

        public function get isMember():Boolean
        {
            return (this._isMember);
        }

        public function get dataLoadedSignal():Signal
        {
            return (this._dataLoadedSignal);
        }

        public function get songDeletedSignal():Signal
        {
            return (this._songDeletedSignal);
        }

        public function get songSharedSignal():Signal
        {
            return (this._songSharedSignal);
        }

        public function get songPlayedSignal():Signal
        {
            return (this._songPlayedSignal);
        }

        public function get songStopSignal():Signal
        {
            return (this._songStopSignal);
        }

        public function get closeModuleSignal():Signal
        {
            return (this._closeModuleSignal);
        }

        public function get songDeletedResponseSignal():Signal
        {
            return (this._songDeletedResponseSignal);
        }

        public function get songSharedResponseSignal():Signal
        {
            return (this._songSharedResponseSignal);
        }

        public function get getLikesSignal():Signal
        {
            return (this._getLikesSignal);
        }

        public function get getLikesResponseSignal():Signal
        {
            return (this._getLikesResponseSignal);
        }

        public function get openStudioSignal():Signal
        {
            return (this._openStudioSignal);
        }

        public function get createTrackSignal():Signal
        {
            return (this._createTrackSignal);
        }


    }
}//package com.clubpenguin.music.mysonglist.model
