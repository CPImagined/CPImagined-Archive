//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Dance extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _SHELL, _ENGINE, _destroyDelegate, _AIRTOWER, _handleGetBroadcastMusicTracks;
        function Dance (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 355;
            _stage.start_y = 310;
            localize([_stage.corner_mc.dance_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 110, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lounge_btn, 675, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.corner_mc.boiler_btn, 505, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.corner_mc.dance_mc.dance_btn, 545, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dj_mc.dj_btn, 350, 165)]);
            _stage.corner_mc.puffle_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, puffleAnimate);
            _stage.corner_mc.puffle_btn.useHandCursor = false;
            _stage.interface_mc.dance_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dance_catalogue");
            _stage.musiccatalog_mc.musiccatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dance_catalogue");
            _stage.dj_mc.dj_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showMixMasterHint);
            _stage.dj_mc.dj_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideMixMasterHint);
            _stage.corner_mc.dance_mc.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showDancingHint);
            _stage.corner_mc.dance_mc.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideDancingHint);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 425, 250);
            _stage.triggers_mc.boiler_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "boiler", 560, 320);
            _stage.triggers_mc.lounge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lounge", 565, 305);
            _stage.triggers_mc.mixmaster_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchMixMasterGame);
            _stage.triggers_mc.dancing_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchDancingGame);
            configureMusicWidgetFunctionality();
        }
        function puffleAnimate() {
            _stage.corner_mc.puffle_mc.gotoAndPlay(188);
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function showMixMasterHint() {
            trace("show hint");
            _INTERFACE.showHint(_stage.hintmixmaster_mc, "mixmaster_hint");
        }
        function hideMixMasterHint() {
            trace("hide hint");
            _INTERFACE.closeHint();
        }
        function launchMixMasterGame() {
            var _local_2 = _SHELL.getLocalizedString("soundstudio_prompt");
            _INTERFACE.closePrompt();
            _INTERFACE.showPrompt("game", _local_2, undefined, com.clubpenguin.util.Delegate.create(this, clickJoinGamePrompt));
        }
        function clickJoinGamePrompt() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("dance_club", "soundstudio_open");
            _SHELL.sendJoinRoom("soundroom", 312, 308);
        }
        function showDancingHint() {
            trace("show hint");
            _INTERFACE.showHint(_stage.hintdancing_mc, "dancing_hint");
        }
        function hideDancingHint() {
            trace("hide hint");
            _INTERFACE.closeHint();
        }
        function launchDancingGame() {
            _ENGINE.sendJoinGame("dancing", true);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
            destroy();
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.sendHideMusicPlayerWidget();
            _AIRTOWER.removeListener(BROADCASTING_MUSIC_TRACKS_EVENT, _handleGetBroadcastMusicTracks);
        }
        function configureMusicWidgetFunctionality() {
            trace("DanceRoom.configureMusicWidgetFunctionality()");
            _SHELL.sendShowMusicPlayerWidget();
            _AIRTOWER = _global.getCurrentAirtower();
            _handleGetBroadcastMusicTracks = com.clubpenguin.util.Delegate.create(this, musicService_getBroadcastMusicTracks_Handler);
            _AIRTOWER.addListener(BROADCASTING_MUSIC_TRACKS_EVENT, _handleGetBroadcastMusicTracks);
            cleanPaperDollDisplay();
            _paperDollGenerator = new com.clubpenguin.world.rooms.common.paperdoll.PaperDollGenerator(_stage, _SHELL, _stage.background_mc.tvscreen_mc.paperdollMC);
        }
        function musicService_getBroadcastMusicTracks_Handler(data) {
            trace(String(data));
            if (data.length < 3) {
                cleanPaperDollDisplay();
                return(undefined);
            }
            data.shift();
            data.shift();
            data.shift();
            if ((data[0] == undefined) || (data[0] == "")) {
                cleanPaperDollDisplay();
                return(undefined);
            }
            var _local_3 = data[0].split(",");
            var _local_5 = new Array();
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                trace("songData " + _local_3[_local_2]);
                var _local_4 = _local_3[_local_2].split("|");
                _local_5.push(_local_4);
                _local_2++;
            }
            var _local_8 = _local_5[0][0];
            var _local_7 = String(_local_5[0][1]);
            if (_local_7 == undefined) {
                cleanPaperDollDisplay();
            } else {
                _stage.background_mc.tvscreen_mc.playerNameLabel.text = String(_local_7);
                _paperDollGenerator.drawPaperDoll(_local_8);
                _stage.background_mc.tvscreen_mc.tvscreen.gotoAndStop("on");
                _stage.background_mc.tvscreen_mc.paperdollMC._visible = true;
            }
            if (_local_8 == _SHELL.getMyPlayerId()) {
                com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(MY_TRACK_PLAYED, BI_CONTEXT_SOUNDSTUDIO);
            }
        }
        function cleanPaperDollDisplay() {
            _stage.background_mc.tvscreen_mc.paperdollMC._visible = false;
            _stage.background_mc.tvscreen_mc.playerNameLabel.text = "";
            _paperDollGenerator.clearPaperDoll();
        }
        static var CLASS_NAME = "Dance";
        static var MUSIC_CATAGORY = "musictrack";
        static var BROADCASTING_MUSIC_TRACKS_EVENT = "broadcastingmusictracks";
        static var BI_CONTEXT_SOUNDSTUDIO = "soundstudio";
        static var MY_TRACK_PLAYED = "dance_club_song_played";
        var _paperDollGenerator = null;
    }
