dynamic class com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager
{
    static var ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD: Number = 50;
    static var MAX_ROOM_EMOTE_START_WAIT_TIME: Number = 10000;
    var _delegateOnPuffleClipLoaded;
    var _engine;
    var _puffleEmoteManager;
    var _roomCareEffects;
    var _roomEmoteStartTimer;
    var _shell;
    var careStationTypeEmoted;

    function PuffleCareEmoteManager(shell, engine, puffleEmoteManager)
    {
        this._shell = shell;
        this._engine = engine;
        this._puffleEmoteManager = puffleEmoteManager;
        this._delegateOnPuffleClipLoaded = com.clubpenguin.util.Delegate.create(this, this.onPuffleClipLoaded);
        this._shell.addListener(this._shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, this.handleJoinRoom));
        this._shell.addListener(this._shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, this.handleRoomDestroyed));
    }

    function showEmote(puffleModel, puffleClip, statTypes, lowStatThreshold)
    {
        var __reg3 = puffleModel.stats.getLowestStatType(statTypes, lowStatThreshold);
        if (__reg3 != null) 
        {
            var __reg2 = undefined;
            if ((__reg0 = __reg3) === com.clubpenguin.shell.PuffleStatsVO.FOOD) 
            {
                __reg2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.FOOD_EMOTICON_PATH;
                this.careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION;
            }
            else if (__reg0 === com.clubpenguin.shell.PuffleStatsVO.PLAY) 
            {
                __reg2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.PLAY_EMOTICON_PATH;
                this.careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION;
            }
            else if (__reg0 === com.clubpenguin.shell.PuffleStatsVO.REST) 
            {
                __reg2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.REST_EMOTICON_PATH;
                this.careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION;
            }
            else if (__reg0 === com.clubpenguin.shell.PuffleStatsVO.CLEAN) 
            {
                __reg2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CLEAN_EMOTICON_PATH;
                this.careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION;
            }
            else 
            {
                return undefined;
            }
            var __reg4 = this._shell.getPath(__reg2);
            this._puffleEmoteManager.showEmote(puffleModel.id, puffleClip, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE, __reg4);
        }
    }

    function handleRoomDestroyed()
    {
        clearTimeout(this._roomEmoteStartTimer);
    }

    function handleJoinRoom()
    {
        this.careStationTypeEmoted = null;
        var __reg2 = this._shell.getMyPlayerObject();
        if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(__reg2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) 
        {
            var __reg3 = this._shell.getRoomObject();
            this._roomCareEffects = com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.getCareEffectsByRoomKey(__reg3.room_key);
            if (this._roomCareEffects != null) 
            {
                clearTimeout(this._roomEmoteStartTimer);
                var __reg4 = Math.floor(Math.random() * com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager.MAX_ROOM_EMOTE_START_WAIT_TIME);
                this._roomEmoteStartTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, this.onRoomEmoteStartTimerDone), __reg4);
            }
        }
    }

    function onRoomEmoteStartTimerDone()
    {
        clearTimeout(this._roomEmoteStartTimer);
        var __reg3 = this._shell.getMyPlayerObject();
        var __reg4 = this._engine.puffleAvatarController.getPuffleAvatar(__reg3.attachedPuffle.id);
        var __reg2 = __reg4.getPuffleClip();
        if (__reg2) 
        {
            this.showEmote(__reg3.attachedPuffle, __reg2, this._roomCareEffects, com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager.ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
            return;
        }
        this._shell.addListener(this._shell.PUFFLE_AVATAR_CLIP_LOADED, this._delegateOnPuffleClipLoaded);
    }

    function onPuffleClipLoaded(puffleID)
    {
        this._shell.removeListener(this._shell.PUFFLE_AVATAR_CLIP_LOADED, this._delegateOnPuffleClipLoaded);
        var __reg2 = this._shell.getMyPlayerObject();
        var __reg3 = this._engine.puffleAvatarController.getPuffleClip(__reg2.attachedPuffle.id);
        if (puffleID == __reg2.attachedPuffle.id) 
        {
            this.showEmote(__reg2.attachedPuffle, __reg3, this._roomCareEffects, com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager.ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
        }
    }

}
