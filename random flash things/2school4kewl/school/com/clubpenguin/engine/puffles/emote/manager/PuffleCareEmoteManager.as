class com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager
{
    var _shell, _engine, _puffleEmoteManager, _delegateOnPuffleClipLoaded, careStationTypeEmoted, _roomEmoteStartTimer, _roomCareEffects;
    function PuffleCareEmoteManager(shell, engine, puffleEmoteManager)
    {
        _shell = shell;
        _engine = engine;
        _puffleEmoteManager = puffleEmoteManager;
        _delegateOnPuffleClipLoaded = com.clubpenguin.util.Delegate.create(this, onPuffleClipLoaded);
        _shell.addListener(_shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, handleJoinRoom));
        _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed));
    } // End of the function
    function showEmote(puffleModel, puffleClip, statTypes, lowStatThreshold)
    {
        trace ("JC:load showEmote");
        var _loc3 = puffleModel.stats.getLowestStatType(statTypes, lowStatThreshold);
        if (_loc3 != null)
        {
            var _loc2;
            switch (_loc3)
            {
                case com.clubpenguin.shell.PuffleStatsVO.FOOD:
                {
                    _loc2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.FOOD_EMOTICON_PATH;
                    careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION;
                    break;
                } 
                case com.clubpenguin.shell.PuffleStatsVO.PLAY:
                {
                    _loc2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.PLAY_EMOTICON_PATH;
                    careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION;
                    break;
                } 
                case com.clubpenguin.shell.PuffleStatsVO.REST:
                {
                    _loc2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.REST_EMOTICON_PATH;
                    careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION;
                    break;
                } 
                case com.clubpenguin.shell.PuffleStatsVO.CLEAN:
                {
                    _loc2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CLEAN_EMOTICON_PATH;
                    careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION;
                    break;
                } 
                default:
                {
                    return;
                } 
            } // End of switch
            var _loc4 = _shell.getPath(_loc2);
            trace ("JC:emotePath " + _loc4);
            _puffleEmoteManager.showEmote(puffleModel.id, puffleClip, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE, _loc4);
        } // end if
    } // End of the function
    function handleRoomDestroyed()
    {
        clearTimeout(_roomEmoteStartTimer);
    } // End of the function
    function handleJoinRoom()
    {
        trace ("JC:PuffleCareEmoteManager handleJoinRoom");
        careStationTypeEmoted = null;
        var _loc2 = _shell.getMyPlayerObject();
        if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_loc2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))
        {
            var _loc3 = _shell.getRoomObject();
            _roomCareEffects = com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.getCareEffectsByRoomKey(_loc3.room_key);
            if (_roomCareEffects != null)
            {
                trace ("JC:PuffleCareEmoteManager there is room care effects for this room");
                clearTimeout(_roomEmoteStartTimer);
                var _loc4 = Math.floor(Math.random() * com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager.MAX_ROOM_EMOTE_START_WAIT_TIME);
                _roomEmoteStartTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, onRoomEmoteStartTimerDone), _loc4);
            } // end if
        } // end if
    } // End of the function
    function onRoomEmoteStartTimerDone()
    {
        trace ("JC:PuffleCareEmoteManager onRoomEmoteStartTimerDone");
        clearTimeout(_roomEmoteStartTimer);
        var _loc3 = _shell.getMyPlayerObject();
        var _loc4 = _engine.puffleAvatarController.getPuffleAvatar(_loc3.attachedPuffle.id);
        var _loc2 = _loc4.getPuffleClip();
        trace ("JC:PuffleCareEmoteManager puffleClip " + _loc2);
        if (_loc2)
        {
            trace ("JC:show emote");
            this.showEmote(_loc3.attachedPuffle, _loc2, _roomCareEffects, com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager.ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
        }
        else
        {
            trace ("JC:load avatar");
            _shell.addListener(_shell.PUFFLE_AVATAR_CLIP_LOADED, _delegateOnPuffleClipLoaded);
        } // end else if
    } // End of the function
    function onPuffleClipLoaded(puffleID)
    {
        trace ("JC:load onPuffleClipLoaded");
        _shell.removeListener(_shell.PUFFLE_AVATAR_CLIP_LOADED, _delegateOnPuffleClipLoaded);
        var _loc2 = _shell.getMyPlayerObject();
        var _loc3 = _engine.puffleAvatarController.getPuffleClip(_loc2.attachedPuffle.id);
        if (puffleID == _loc2.attachedPuffle.id)
        {
            this.showEmote(_loc2.attachedPuffle, _loc3, _roomCareEffects, com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager.ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
        } // end if
    } // End of the function
    static var ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD = 50;
    static var MAX_ROOM_EMOTE_START_WAIT_TIME = 10000;
} // End of Class
