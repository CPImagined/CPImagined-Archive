dynamic class com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation
{
    static var ACTIVITY_TIME: Number = 5000;
    var _ENGINE;
    var _SHELL;
    var _activityTimer;
    var _animationLoadsExternally;
    var _assetPath;
    var _careItemID;
    var _careSound;
    var _effect;
    var _effectMC;
    var _hideHat;
    var _pixelPerfect;
    var _playerLocation;
    var _puffleAnimationLoader;
    var _puffleCareQuest;
    var _puffleFrame;
    var _soundEffect;
    var _stationName;
    var _stationPlayers;
    var _stationType;
    var _stationUsesEffectMC;
    var _stationUsesSound;
    var _taskNumber;

    function HotelCareStation(hotelCareStationVO)
    {
        if (hotelCareStationVO.effectRef) 
        {
            this._stationUsesEffectMC = true;
            this._effectMC = hotelCareStationVO.effectRef;
        }
        else 
        {
            this._stationUsesEffectMC = false;
        }
        this._SHELL = _global.getCurrentShell();
        this._ENGINE = _global.getCurrentEngine();
        this._puffleCareQuest = this._SHELL.getRainbowPuffleQuest();
        this._taskNumber = hotelCareStationVO.taskEnum.taskNumber;
        this._effect = hotelCareStationVO.taskEnum.effect;
        this._careItemID = hotelCareStationVO.taskEnum.careItemID;
        this._puffleFrame = hotelCareStationVO.puffleFrame;
        if (hotelCareStationVO.assetPath) 
        {
            this._animationLoadsExternally = true;
            this._assetPath = hotelCareStationVO.assetPath;
        }
        else 
        {
            this._animationLoadsExternally = false;
        }
        if (hotelCareStationVO.careSound) 
        {
            this._careSound = hotelCareStationVO.careSound;
            this._stationUsesSound = true;
        }
        if (hotelCareStationVO.hideHat) 
        {
            this._hideHat = hotelCareStationVO.hideHat;
        }
        if (hotelCareStationVO.playerLocation) 
        {
            this._playerLocation = hotelCareStationVO.playerLocation;
            this._pixelPerfect = true;
        }
        this._stationPlayers = new Array();
        this._SHELL.addListener(this._SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer));
        this._SHELL.addListener(this._SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, this.handlePufflePerformingTrick));
    }

    function stationBIInfo(stationName, stationType)
    {
        this._stationName = stationName;
        this._stationType = stationType;
    }

    function beginActivity(players)
    {
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= players.length) 
            {
                return;
            }
            var __reg6 = this._ENGINE.getPlayerMovieClip(players[__reg2]);
            var __reg8 = this._SHELL.getPlayerObjectById(players[__reg2]);
            var __reg4 = __reg8.attachedPuffle.id;
            if (this._puffleCareQuest.isPuffleEquipped(players[__reg2]) && __reg8.avatarVO.avatar_id != 1 && this._ENGINE.puffleAvatarController.isPuffleVisible(__reg4) && this._ENGINE.puffleAvatarController.getPuffleCanMove(__reg4)) 
            {
                this._stationPlayers.push(Number(players[__reg2]));
                var __reg3 = this._SHELL.isMyPlayer(Number(players[__reg2]));
                if (this._pixelPerfect) 
                {
                    __reg6._x = this._playerLocation.x;
                    __reg6._y = this._playerLocation.y;
                }
                if (this._stationUsesEffectMC) 
                {
                    if (__reg3 || this._effectMC._currentframe == 1) 
                    {
                        this._effectMC.gotoAndPlay(2);
                        if (__reg3) 
                        {
                            this._effectMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, this.effectEnterFrameHandler, __reg6);
                        }
                    }
                }
                else if (__reg3) 
                {
                    this._activityTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, this.performActionByTime), com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation.ACTIVITY_TIME);
                }
                if (this._animationLoadsExternally) 
                {
                    this._puffleAnimationLoader = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(players[__reg2], __reg4, this._SHELL, this._ENGINE);
                    var __reg7 = this._SHELL.getPath(this._assetPath);
                    __reg7 = __reg8.attachedPuffle.getFormattedAssetURL(__reg7);
                    this._puffleAnimationLoader.playPuffleAnimation(__reg7);
                }
                else 
                {
                    this._ENGINE.puffleAvatarController.setFrameUpdateEnabled(__reg4, false);
                    if (this._hideHat) 
                    {
                        this._ENGINE.puffleAvatarController.hideHat(__reg4);
                    }
                    this._ENGINE.puffleAvatarController.updatePuffleFrame(__reg4, this._puffleFrame);
                }
                if (this._stationUsesSound && (this._careSound.playForRemoteClients || __reg3)) 
                {
                    this._soundEffect = new Sound(this._careSound.attachRef);
                    this._soundEffect.attachSound(this._careSound.soundLinkage);
                    this._soundEffect.start(0, 999);
                }
            }
            if (__reg3) 
            {
                if (this._stationName != undefined || this._stationType != undefined) 
                {
                    com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(this._stationName, this._stationType);
                }
            }
            ++__reg2;
        }
    }

    function effectEnterFrameHandler(playerMC)
    {
        if (this._effectMC._currentframe == this._effectMC._totalframes) 
        {
            this.performAction();
            delete this._effectMC.onEnterFrame;
        }
    }

    function performActionByTime(timeEvent)
    {
        clearTimeout(this._activityTimer);
        this.performAction();
    }

    function performAction()
    {
        var __reg2 = this._SHELL.getMyPlayerObject().attachedPuffle.id;
        this._ENGINE.puffleAvatarController.displayPuffleWidget(__reg2, "statsBarWidget", this._careItemID);
        if (this._SHELL.getRoomObject().room_id == 430 || this._SHELL.getRoomObject().room_id == 431 || this._SHELL.getRoomObject().room_id == 432) 
        {
            this.completeTask();
            return;
        }
        return undefined;
    }

    function completeTask()
    {
        if (this._taskNumber != undefined) 
        {
            if (this._puffleCareQuest.__get__currentPuffleQuestTaskIndex() == this._taskNumber - 1 && this._puffleCareQuest.isNextPuffleQuestTaskAvailable() && !this._puffleCareQuest.isTaskComplete(this._taskNumber)) 
            {
                var __reg2 = setTimeout(this.showQuestUI, 1000);
            }
            this._puffleCareQuest.completePuffleQuestTask(this._taskNumber);
        }
    }

    function showQuestUI()
    {
        _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
    }

    function endActivity(players)
    {
        var __reg4 = 0;
        while (__reg4 < this._stationPlayers.length) 
        {
            var __reg2 = 0;
            while (__reg2 < players.length) 
            {
                if (Number(this._stationPlayers[__reg4]) == Number(players[__reg2])) 
                {
                    this._stationPlayers.splice(__reg4, 1);
                    break;
                }
                ++__reg2;
            }
            ++__reg4;
        }
        __reg4 = 0;
        for (;;) 
        {
            if (__reg4 >= players.length) 
            {
                return;
            }
            if (this._animationLoadsExternally) 
            {
                this._puffleAnimationLoader.cancelAndRemoveAnimation();
            }
            else 
            {
                var __reg6 = this._SHELL.getPlayerObjectById(players[__reg4]);
                var __reg5 = __reg6.attachedPuffle.id;
                this._ENGINE.puffleAvatarController.setFrameUpdateEnabled(__reg5, true);
                this._ENGINE.puffleAvatarController.updatePuffleFrame(__reg5, this._ENGINE.getPlayerMovieClip(__reg6.player_id).frame);
                this._ENGINE.puffleAvatarController.showHat(__reg5);
            }
            if (this._stationUsesSound) 
            {
                this._soundEffect.stop();
            }
            if (this._SHELL.isMyPlayer(players[__reg4]) || this._stationPlayers.length == 0) 
            {
                delete this._effectMC.onEnterFrame;
                this._effectMC.gotoAndStop(1);
            }
            ++__reg4;
        }
    }

    function handlePufflePerformingTrick(event)
    {
        if (event.playerId == this._SHELL.getMyPlayerId()) 
        {
            this.endActivity([event.playerId]);
            clearInterval(this._activityTimer);
        }
    }

    function cleanStation()
    {
        clearTimeout(this._activityTimer);
        this._SHELL.removeListener(this._SHELL.UPDATE_PLAYER, this.handleUpdatePlayer);
        this._SHELL.removeListener(this._SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, this.handlePufflePerformingTrick));
        var __reg2 = this._SHELL.getMyPlayerObject();
        if (this._puffleCareQuest.isPuffleEquipped(__reg2.player_id)) 
        {
            this._ENGINE.puffleAvatarController.setFrameUpdateEnabled(__reg2.attachedPuffle.id, true);
        }
        if (this._stationUsesSound) 
        {
            this._soundEffect.stop();
        }
    }

    function handleUpdatePlayer(player_ob)
    {
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= this._stationPlayers.length) 
            {
                return;
            }
            if (player_ob.player_id == this._stationPlayers[__reg2] && !this._puffleCareQuest.isPuffleEquipped(player_ob.player_id)) 
            {
                var __reg3 = new Array();
                __reg3.push(player_ob.player_id);
                this.endActivity(__reg3);
            }
            ++__reg2;
        }
    }

}
