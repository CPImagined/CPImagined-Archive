class com.clubpenguin.world.rooms2014.music.MusicJamPerformances
{
    var _stage, _INTERFACE, _SHELL, _updateMusicTrackDelegate, _airtower, _handleReceiveConcertElapsedDelegate, _handleReceiveConcertCountdownDelegate, _countdownInterval, musicTrack, _concertCountdown;
    function MusicJamPerformances(stage)
    {
        _stage = stage;
        _INTERFACE = _global.getCurrentInterface();
        _SHELL = _global.getCurrentShell();
        this.configurePerformanceStage();
        _updateMusicTrackDelegate = com.clubpenguin.util.Delegate.create(this, updateMusicTrack);
        _SHELL.addListener(_SHELL.UPDATE_MUSIC, _updateMusicTrackDelegate);
    } // End of the function
    function configurePerformanceStage()
    {
        _stage.stage_mc.musicPlayer_mc._visible = false;
        _airtower = _global.getCurrentAirtower();
        _handleReceiveConcertElapsedDelegate = com.clubpenguin.util.Delegate.create(this, handleReceiveCurrentConcertElapsed);
        _handleReceiveConcertCountdownDelegate = com.clubpenguin.util.Delegate.create(this, handleConcertUpdate);
        _airtower.addListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().GET_CONCERT_ELAPSED, _handleReceiveConcertElapsedDelegate);
        _airtower.addListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().GET_CONCERT_COUNTDOWN, _handleReceiveConcertCountdownDelegate);
        com.clubpenguin.world.rooms2014.music.party.MusicParty.sendGetConcertCountdown();
    } // End of the function
    function cleanPerformances()
    {
        _airtower.removeListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().GET_CONCERT_ELAPSED, _handleReceiveConcertElapsedDelegate);
        _airtower.removeListener(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().GET_CONCERT_COUNTDOWN, _handleReceiveConcertCountdownDelegate);
    } // End of the function
    function handleConcertUpdate(data)
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("MusicJamPerformance.handleConcertUpdate() data " + data);
        var _loc3 = data[1];
        var _loc2 = data[2];
        var _loc5 = data[3];
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("MusicJamPerformance.handleConcertUpdate() _concertOnStage " + _concertOnStage);
        if (_concertOnStage)
        {
            return;
        } // end if
        if (_loc2 <= 0)
        {
            this.handleReceiveNextConcertCountdown(_loc2);
            return;
        } // end if
        clearInterval(_countdownInterval);
        this.handleReceiveNextConcertCountdown(_loc2);
        if (!com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(_loc3))
        {
            return;
        } // end if
        this.updateShowScheduleBoard(_loc3, _loc5, musicTrack != null);
        if (_loc2 == 0)
        {
            this.handleConcertStart(_loc3);
        } // end if
    } // End of the function
    function handleReceiveNextConcertCountdown(countdownTime)
    {
        if (countdownTime != undefined)
        {
            _countdownInterval = setInterval(com.clubpenguin.util.Delegate.create(this, handleReceiveNextConcertCountdown), 1000);
        } // end if
        var _loc4 = countdownTime == undefined ? (_concertCountdown) : (countdownTime);
        _concertCountdown = _loc4;
        if (_concertCountdown > 0)
        {
            _concertCountdown = _concertCountdown - 1000;
        } // end if
        var _loc6 = Math.round(_loc4 / 1000);
        var _loc3 = Math.floor(_loc6 / 60);
        var _loc2 = _loc6 - _loc3 * 60;
        if (_loc3 < 0 || isNaN(_loc3))
        {
            _loc3 = 0;
        } // end if
        if (_loc2 < 0 || isNaN(_loc2))
        {
            _loc2 = 0;
        } // end if
        var _loc5 = _loc2 < 10 ? ("0" + _loc2) : (_loc2);
        if (_loc3 == 0 && _loc5 == 0)
        {
            clearInterval(_countdownInterval);
        } // end if
        this.updateCountdownTimer(String(_loc3 + ":" + _loc5));
    } // End of the function
    function updateCountdownTimer(timeString)
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("updateCountdownTimer " + timeString);
        if (timeString != "0:00")
        {
            _stage.background_mc.countdown_mc.timer_mc.timerbitmap_mc.digit.text = timeString;
            if (_stage.background_mc.countdown_mc.timer_mc._currentframe == 1)
            {
                var _loc3 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_stage.background_mc.countdown_mc.timer_mc, com.clubpenguin.util.Delegate.create(this, updateCountdownTimer, timeString), 2, 10);
            } // end if
        }
        else
        {
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("The countdown is zero");
            clearInterval(_countdownInterval);
            _stage.background_mc.scheduleText_mc.gotoAndStop("performing");
            if (_stage.background_mc.countdown_mc.timer_mc._currentframe == 10)
            {
                _stage.background_mc.countdown_mc.timer_mc.gotoAndPlay(11);
            } // end if
        } // end else if
    } // End of the function
    function setTimerMinutesPlural(isPlural)
    {
        var _loc2 = "singular";
        if (isPlural)
        {
            _loc2 = "plural";
        } // end if
        _stage.background_mc.countdown_mc.timer_mc.timerbitmap_mc.minutes_mc.gotoAndStop(_loc2);
    } // End of the function
    function handleConcertStart(performerID, elapsedTime)
    {
        this.stopPerformances();
        if (!com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(performerID))
        {
            return;
        } // end if
        var _loc3 = com.clubpenguin.world.rooms2014.music.party.MusicParty.getPerformerNameByID(performerID);
        var _loc2 = _loc3.split(" ").join("").toLowerCase();
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("Set concert on stage");
        _concertOnStage = true;
        this.loadPerformance(_loc2, elapsedTime);
        this.lowerCurtains(_loc2);
    } // End of the function
    function startPerformance(performerName, elapsedTime)
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("startPerformance");
        com.clubpenguin.world.rooms2014.music.party.MusicParty.sendAttendPerformanceBI(performerName);
        this.updateShowScheduleBoard(performerName, undefined, true);
        this.updateCountdownTimer("0:00");
        if (musicTrack != undefined && _concertOnStage)
        {
            return;
        } // end if
        var _loc2 = _stage.foreground_mc.concertContainer["concert_" + performerName];
        if (_loc2 == undefined)
        {
            return;
        } // end if
        _loc2._visible = true;
        var _loc3 = 2;
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("Load music track");
        musicTrack = new Sound(_loc2);
        musicTrack.attachSound("music_" + performerName);
        var _loc5 = 0;
        if (elapsedTime != undefined)
        {
            var _loc7 = _loc2._totalframes / com.clubpenguin.world.rooms2014.music.MusicJamPerformances.FRAMES_PER_SECOND * 1000;
            var _loc6 = elapsedTime / _loc7;
            _loc3 = Math.round(_loc2._totalframes * _loc6);
            if (_loc3 == 0)
            {
                _loc3 = 2;
            } // end if
            _loc5 = musicTrack.duration * _loc6 / 1000;
        } // end if
        musicTrack.start(_loc5);
        musicTrack.setVolume(_SHELL.MUSIC.isMusicMuted() ? (0) : (100));
        if (_loc3 > _loc2._totalframes)
        {
            return;
        } // end if
        var _loc9 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_loc2, com.clubpenguin.util.Delegate.create(this, handleConcertEnd), _loc3, _loc2._totalframes);
        _loc2.performerMC.gotoAndStop("perform");
        _loc2.giveaway_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, handlePickupBackgroundGiveaway, performerName);
        if (performerName == "cadence")
        {
            _loc2.penguinBand_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, handlePickupBackgroundGiveaway, "penguinband");
        } // end if
    } // End of the function
    function handleReceiveCurrentConcertElapsed(data)
    {
        var _loc3 = data[1];
        var _loc2 = data[2];
        var _loc5 = data[3];
        if (this.getIsConcertOnStage(_loc2))
        {
            this.updateShowScheduleBoard(_loc3, _loc5, this.getIsConcertOnStage(_loc2));
            this.handleConcertStart(_loc3, _loc2);
        } // end if
    } // End of the function
    function getIsConcertOnStage(elapsedTime)
    {
        return (elapsedTime < com.clubpenguin.world.rooms2014.music.MusicJamPerformances.MAXIMUM_CONCERT_LENGTH * 1000 && elapsedTime != undefined);
    } // End of the function
    function updateShowScheduleBoard(nextShowId, followingShowId, performing)
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("updateShowScheduleBoard() nextShowId " + nextShowId + " followingShowId " + followingShowId + " performing " + performing);
        if (com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(nextShowId))
        {
            var _loc5 = com.clubpenguin.world.rooms2014.music.party.MusicParty.getPerformerNameByID(nextShowId).split(" ").join("");
            var _loc6 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS()["PERFORMER_NAME_" + _loc5.toUpperCase()];
            _stage.background_mc.nextShow.text = _SHELL.getLocalizedString(_loc6);
        } // end if
        if (com.clubpenguin.world.rooms2014.music.party.MusicParty.getIsValidConcertId(followingShowId))
        {
            var _loc7 = com.clubpenguin.world.rooms2014.music.party.MusicParty.getPerformerNameByID(followingShowId).split(" ").join("");
            var _loc3 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS()["PERFORMER_NAME_" + _loc7.toUpperCase()];
            _stage.background_mc.followingShow.text = _SHELL.getLocalizedString(_loc3);
        } // end if
        _stage.background_mc.scheduleText_mc.gotoAndStop(performing ? ("performing") : ("countdown"));
    } // End of the function
    function updateMusicTrack()
    {
        musicTrack.setVolume(_SHELL.MUSIC.isMusicMuted() ? (0) : (100));
    } // End of the function
    function loadPerformance(performerName, elapsedTime)
    {
        trace ("MusicJamPerformance.loadPerformance performerName " + performerName);
        if (_stage.foreground_mc.concertContainer["concert_" + performerName] != undefined)
        {
            _currentPerformanceLoaded = true;
            return;
        } // end if
        var _loc6 = _stage.foreground_mc.concertContainer.createEmptyMovieClip("concert_" + performerName, _stage.foreground_mc.concertContainer.getNextHighestDepth());
        var _loc4 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS()["CONCERT_TOKEN_" + performerName.toUpperCase()];
        var _loc5 = _SHELL.getPath(_loc4);
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleExternalAssetLoaded, performerName, elapsedTime));
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, handleLoadError));
        _loc3.loadClip(_loc5, _loc6, "DeckStage loadConcert() " + performerName);
    } // End of the function
    function handleLoadError(event, concertMC)
    {
        trace ("Concert failed to load, removing movieclip");
        concertMC.removeMovieClip();
    } // End of the function
    function handleExternalAssetLoaded(event, performerName, elapsedTime)
    {
        trace ("Concert loaded performerName " + performerName);
        trace ("Concert loaded elapsedTime " + elapsedTime);
        var _loc2 = _stage.foreground_mc.concertContainer["concert_" + performerName];
        _loc2.gotoAndStop(1);
        if (elapsedTime != undefined || _waitingForPerformanceLoad)
        {
            this.raiseCurtains();
            this.startPerformance(performerName, elapsedTime);
            _waitingForPerformanceLoad = false;
        } // end if
    } // End of the function
    function handlePickupBackgroundGiveaway(performerName)
    {
        var _loc2 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS()["BACKGROUND_ITEM_" + performerName.toUpperCase()];
        _INTERFACE.buyInventory(_loc2);
    } // End of the function
    function lowerCurtains(performerName)
    {
        _stage.foreground_mc.curtain.gotoAndPlay(2);
        _stage.foreground_mc.curtain.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackCurtainAnim, performerName != undefined ? (true) : (false), performerName);
        _stage.background_mc.curtain.gotoAndPlay(2);
    } // End of the function
    function raiseCurtains()
    {
        _stage.foreground_mc.curtain.gotoAndPlay("lowered");
        _stage.background_mc.curtain.gotoAndPlay("lowered");
    } // End of the function
    function trackCurtainAnim(showConcert, performerName)
    {
        if (_stage.foreground_mc.curtain._currentframe == 20)
        {
            _stage.foreground_mc.curtain.onEnterFrame = null;
            if (!_currentPerformanceLoaded && showConcert)
            {
                _stage.foreground_mc.curtain.stop();
                _stage.background_mc.curtain.stop();
                _waitingForPerformanceLoad = true;
            }
            else if (showConcert)
            {
                this.startPerformance(performerName);
            }
            else
            {
                this.stopPerformances();
            } // end else if
        } // end else if
    } // End of the function
    function handleConcertEnd()
    {
        this.lowerCurtains();
        _currentPerformanceLoaded = false;
        _waitingForPerformanceLoad = false;
        musicTrack.stop();
        musicTrack = null;
        _concertOnStage = false;
        clearInterval(_countdownInterval);
        com.clubpenguin.world.rooms2014.music.party.MusicParty.sendGetConcertCountdown();
    } // End of the function
    function stopPerformances()
    {
        for (var _loc3 in _stage.foreground_mc.concertContainer)
        {
            var _loc2 = _stage.foreground_mc.concertContainer[_loc3];
            _loc2._visible = false;
            _loc2.gotoAndStop(1);
        } // end of for...in
        _currentPerformanceLoaded = false;
        _waitingForPerformanceLoad = false;
        musicTrack.stop();
        musicTrack = undefined;
        _concertOnStage = false;
    } // End of the function
    function clean()
    {
        this.cleanPerformances();
        this.stopPerformances();
        clearInterval(_countdownInterval);
    } // End of the function
    static var FRAMES_PER_SECOND = 24;
    static var MAXIMUM_CONCERT_LENGTH = 120;
    var _concertOnStage = false;
    var _currentPerformanceLoaded = false;
    var _waitingForPerformanceLoad = false;
} // End of Class
