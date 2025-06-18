//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.MusicJamPerformances
    {
        var _stage, _INTERFACE, _SHELL, _updateMusicTrackDelegate, _airtower, _handleReceiveConcertElapsedDelegate, _handleReceiveConcertCountdownDelegate, _countdownInterval, musicTrack, _concertCountdown;
        function MusicJamPerformances (stage) {
            _stage = stage;
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            configurePerformanceStage();
            _updateMusicTrackDelegate = com.clubpenguin.util.Delegate.create(this, updateMusicTrack);
            _SHELL.addListener(_SHELL.UPDATE_MUSIC, _updateMusicTrackDelegate);
        }
        function configurePerformanceStage() {
            _stage.stage_mc.musicPlayer_mc._visible = false;
            _airtower = _global.getCurrentAirtower();
            _handleReceiveConcertElapsedDelegate = com.clubpenguin.util.Delegate.create(this, handleReceiveCurrentConcertElapsed);
            _handleReceiveConcertCountdownDelegate = com.clubpenguin.util.Delegate.create(this, handleConcertUpdate);
            _airtower.addListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS.GET_CONCERT_ELAPSED, _handleReceiveConcertElapsedDelegate);
            _airtower.addListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS.GET_CONCERT_COUNTDOWN, _handleReceiveConcertCountdownDelegate);
            com.clubpenguin.world.rooms2014.music.party.MusicParty.sendGetConcertCountdown();
        }
        function cleanPerformances() {
            _airtower.removeListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS.GET_CONCERT_ELAPSED, _handleReceiveConcertElapsedDelegate);
            _airtower.removeListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS.GET_CONCERT_COUNTDOWN, _handleReceiveConcertCountdownDelegate);
        }
        function handleConcertUpdate(data) {
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("MusicJamPerformance.handleConcertUpdate() data " + data);
            var _local_3 = data[1];
            var _local_2 = data[2];
            var _local_5 = data[3];
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("MusicJamPerformance.handleConcertUpdate() _concertOnStage " + _concertOnStage);
            if (_concertOnStage) {
                return(undefined);
            }
            if (_local_2 <= 0) {
                handleReceiveNextConcertCountdown(_local_2);
                return(undefined);
            }
            clearInterval(_countdownInterval);
            handleReceiveNextConcertCountdown(_local_2);
            if (!com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(_local_3)) {
                return(undefined);
            }
            updateShowScheduleBoard(_local_3, _local_5, musicTrack != null);
            if (_local_2 == 0) {
                handleConcertStart(_local_3);
            }
        }
        function handleReceiveNextConcertCountdown(countdownTime) {
            if (countdownTime != undefined) {
                _countdownInterval = setInterval(com.clubpenguin.util.Delegate.create(this, handleReceiveNextConcertCountdown), 1000);
            }
            var _local_4 = ((countdownTime == undefined) ? (_concertCountdown) : (countdownTime));
            _concertCountdown = _local_4;
            if (_concertCountdown > 0) {
                _concertCountdown = _concertCountdown - 1000;
            }
            var _local_6 = Math.round(_local_4 / 1000);
            var _local_3 = Math.floor(_local_6 / 60);
            var _local_2 = _local_6 - (_local_3 * 60);
            if ((_local_3 < 0) || (isNaN(_local_3))) {
                _local_3 = 0;
            }
            if ((_local_2 < 0) || (isNaN(_local_2))) {
                _local_2 = 0;
            }
            var _local_5 = ((_local_2 < 10) ? ("0" + _local_2) : (_local_2));
            if ((_local_3 == 0) && (_local_5 == 0)) {
                clearInterval(_countdownInterval);
            }
            updateCountdownTimer(String((_local_3 + ":") + _local_5));
        }
        function updateCountdownTimer(timeString) {
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("updateCountdownTimer " + timeString);
            if (timeString != "0:00") {
                _stage.background_mc.countdown_mc.timer_mc.timerbitmap_mc.digit.text = timeString;
                if (_stage.background_mc.countdown_mc.timer_mc._currentframe == 1) {
                    var _local_3 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_stage.background_mc.countdown_mc.timer_mc, com.clubpenguin.util.Delegate.create(this, updateCountdownTimer, timeString), 2, 10);
                }
            } else {
                com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("The countdown is zero");
                clearInterval(_countdownInterval);
                _stage.background_mc.scheduleText_mc.gotoAndStop("performing");
                if (_stage.background_mc.countdown_mc.timer_mc._currentframe == 10) {
                    _stage.background_mc.countdown_mc.timer_mc.gotoAndPlay(11);
                }
            }
        }
        function setTimerMinutesPlural(isPlural) {
            var _local_2 = "singular";
            if (isPlural) {
                _local_2 = "plural";
            }
            _stage.background_mc.countdown_mc.timer_mc.timerbitmap_mc.minutes_mc.gotoAndStop(_local_2);
        }
        function handleConcertStart(performerID, elapsedTime) {
            stopPerformances();
            if (!com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(performerID)) {
                return(undefined);
            }
            var _local_3 = com.clubpenguin.world.rooms2014.music.party.MusicParty.getPerformerNameByID(performerID);
            var _local_2 = _local_3.split(" ").join("").toLowerCase();
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("Set concert on stage");
            _concertOnStage = true;
            loadPerformance(_local_2, elapsedTime);
            lowerCurtains(_local_2);
        }
        function startPerformance(performerName, elapsedTime) {
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("startPerformance");
            com.clubpenguin.world.rooms2014.music.party.MusicParty.sendAttendPerformanceBI(performerName);
            updateShowScheduleBoard(performerName, undefined, true);
            updateCountdownTimer("0:00");
            if ((musicTrack != undefined) && (_concertOnStage)) {
                return(undefined);
            }
            var _local_2 = _stage.foreground_mc.concertContainer["concert_" + performerName];
            if (_local_2 == undefined) {
                return(undefined);
            }
            _local_2._visible = true;
            var _local_3 = 2;
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("Load music track");
            musicTrack = new Sound(_local_2);
            musicTrack.attachSound("music_" + performerName);
            var _local_5 = 0;
            if (elapsedTime != undefined) {
                var _local_7 = (_local_2._totalframes / FRAMES_PER_SECOND) * 1000;
                var _local_6 = elapsedTime / _local_7;
                _local_3 = Math.round(_local_2._totalframes * _local_6);
                if (_local_3 == 0) {
                    _local_3 = 2;
                }
                _local_5 = (musicTrack.duration * _local_6) / 1000;
            }
            musicTrack.start(_local_5);
            musicTrack.setVolume((_SHELL.MUSIC.isMusicMuted() ? 0 : 100));
            if (_local_3 > _local_2._totalframes) {
                return(undefined);
            }
            var _local_9 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_local_2, com.clubpenguin.util.Delegate.create(this, handleConcertEnd), _local_3, _local_2._totalframes);
            _local_2.performerMC.gotoAndStop("perform");
            _local_2.giveaway_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, handlePickupBackgroundGiveaway, performerName);
            if (performerName == "cadence") {
                _local_2.penguinBand_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, handlePickupBackgroundGiveaway, "penguinband");
            }
        }
        function handleReceiveCurrentConcertElapsed(data) {
            var _local_3 = data[1];
            var _local_2 = data[2];
            var _local_5 = data[3];
            if (getIsConcertOnStage(_local_2)) {
                updateShowScheduleBoard(_local_3, _local_5, getIsConcertOnStage(_local_2));
                handleConcertStart(_local_3, _local_2);
            }
        }
        function getIsConcertOnStage(elapsedTime) {
            return((elapsedTime < (MAXIMUM_CONCERT_LENGTH * 1000)) && (elapsedTime != undefined));
        }
        function updateShowScheduleBoard(nextShowId, followingShowId, performing) {
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug((((("updateShowScheduleBoard() nextShowId " + nextShowId) + " followingShowId ") + followingShowId) + " performing ") + performing);
            if (com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(nextShowId)) {
                var _local_5 = com.clubpenguin.world.rooms2014.music.party.MusicParty.getPerformerNameByID(nextShowId).split(" ").join("");
                var _local_6 = com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS["PERFORMER_NAME_" + _local_5.toUpperCase()];
                _stage.background_mc.nextShow.text = _SHELL.getLocalizedString(_local_6);
            }
            if (com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(followingShowId)) {
                var _local_7 = com.clubpenguin.world.rooms2014.music.party.MusicParty.getPerformerNameByID(followingShowId).split(" ").join("");
                var _local_3 = com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS["PERFORMER_NAME_" + _local_7.toUpperCase()];
                _stage.background_mc.followingShow.text = _SHELL.getLocalizedString(_local_3);
            }
            _stage.background_mc.scheduleText_mc.gotoAndStop((performing ? "performing" : "countdown"));
        }
        function updateMusicTrack() {
            musicTrack.setVolume((_SHELL.MUSIC.isMusicMuted() ? 0 : 100));
        }
        function loadPerformance(performerName, elapsedTime) {
            if (_stage.foreground_mc.concertContainer["concert_" + performerName] != undefined) {
                _currentPerformanceLoaded = true;
                return(undefined);
            }
            var _local_6 = _stage.foreground_mc.concertContainer.createEmptyMovieClip("concert_" + performerName, _stage.foreground_mc.concertContainer.getNextHighestDepth());
            var _local_4 = com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS["CONCERT_TOKEN_" + performerName.toUpperCase()];
            var _local_5 = _SHELL.getPath(_local_4);
            var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleExternalAssetLoaded, performerName, elapsedTime));
            _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, handleLoadError));
            _local_3.loadClip(_local_5, _local_6, "DeckStage loadConcert() " + performerName);
        }
        function handleLoadError(event, concertMC) {
            concertMC.removeMovieClip();
        }
        function handleExternalAssetLoaded(event, performerName, elapsedTime) {
            var _local_2 = _stage.foreground_mc.concertContainer["concert_" + performerName];
            _local_2.gotoAndStop(1);
            if ((elapsedTime != undefined) || (_waitingForPerformanceLoad)) {
                raiseCurtains();
                startPerformance(performerName, elapsedTime);
                _waitingForPerformanceLoad = false;
            }
        }
        function handlePickupBackgroundGiveaway(performerName) {
            var _local_2 = com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS["BACKGROUND_ITEM_" + performerName.toUpperCase()];
            _INTERFACE.buyInventory(_local_2);
        }
        function lowerCurtains(performerName) {
            _stage.foreground_mc.curtain.gotoAndPlay(2);
            _stage.foreground_mc.curtain.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackCurtainAnim, ((performerName != undefined) ? true : false), performerName);
            _stage.background_mc.curtain.gotoAndPlay(2);
        }
        function raiseCurtains() {
            _stage.foreground_mc.curtain.gotoAndPlay("lowered");
            _stage.background_mc.curtain.gotoAndPlay("lowered");
        }
        function trackCurtainAnim(showConcert, performerName) {
            if (_stage.foreground_mc.curtain._currentframe == 20) {
                _stage.foreground_mc.curtain.onEnterFrame = null;
                if ((!_currentPerformanceLoaded) && (showConcert)) {
                    _stage.foreground_mc.curtain.stop();
                    _stage.background_mc.curtain.stop();
                    _waitingForPerformanceLoad = true;
                } else if (showConcert) {
                    startPerformance(performerName);
                } else {
                    stopPerformances();
                }
            }
        }
        function handleConcertEnd() {
            lowerCurtains();
            _currentPerformanceLoaded = false;
            _waitingForPerformanceLoad = false;
            musicTrack.stop();
            musicTrack = null;
            _concertOnStage = false;
            clearInterval(_countdownInterval);
            com.clubpenguin.world.rooms2014.music.party.MusicParty.sendGetConcertCountdown();
        }
        function stopPerformances() {
            for (var _local_3 in _stage.foreground_mc.concertContainer) {
                var _local_2 = _stage.foreground_mc.concertContainer[_local_3];
                _local_2._visible = false;
                _local_2.gotoAndStop(1);
            }
            _currentPerformanceLoaded = false;
            _waitingForPerformanceLoad = false;
            musicTrack.stop();
            musicTrack = undefined;
            _concertOnStage = false;
        }
        function clean() {
            cleanPerformances();
            stopPerformances();
            clearInterval(_countdownInterval);
        }
        static var FRAMES_PER_SECOND = 24;
        static var MAXIMUM_CONCERT_LENGTH = 120;
        var _concertOnStage = false;
        var _currentPerformanceLoaded = false;
        var _waitingForPerformanceLoad = false;
    }
