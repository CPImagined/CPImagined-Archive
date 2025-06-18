//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager
    {
        var _shell, _engine, _puffleEmoteManager, _delegateOnPuffleClipLoaded, careStationTypeEmoted, _roomEmoteStartTimer, _roomCareEffects;
        function PuffleCareEmoteManager (shell, engine, puffleEmoteManager) {
            _shell = shell;
            _engine = engine;
            _puffleEmoteManager = puffleEmoteManager;
            _delegateOnPuffleClipLoaded = com.clubpenguin.util.Delegate.create(this, onPuffleClipLoaded);
            _shell.addListener(_shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, handleJoinRoom));
            _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed));
        }
        function showEmote(puffleModel, puffleClip, statTypes, lowStatThreshold) {
            trace("JC:load showEmote");
            var _local_3 = puffleModel.stats.getLowestStatType(statTypes, lowStatThreshold);
            if (_local_3 != null) {
                var _local_2;
                switch (_local_3) {
                    case com.clubpenguin.shell.PuffleStatsVO.FOOD : 
                        _local_2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.FOOD_EMOTICON_PATH;
                        careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION;
                        break;
                    case com.clubpenguin.shell.PuffleStatsVO.PLAY : 
                        _local_2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.PLAY_EMOTICON_PATH;
                        careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION;
                        break;
                    case com.clubpenguin.shell.PuffleStatsVO.REST : 
                        _local_2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.REST_EMOTICON_PATH;
                        careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION;
                        break;
                    case com.clubpenguin.shell.PuffleStatsVO.CLEAN : 
                        _local_2 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CLEAN_EMOTICON_PATH;
                        careStationTypeEmoted = com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION;
                        break;
                    default : 
                        return(undefined);
                }
                var _local_4 = _shell.getPath(_local_2);
                trace("JC:emotePath " + _local_4);
                _puffleEmoteManager.showEmote(puffleModel.id, puffleClip, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE, _local_4);
            }
        }
        function handleRoomDestroyed() {
            clearTimeout(_roomEmoteStartTimer);
        }
        function handleJoinRoom() {
            trace("JC:PuffleCareEmoteManager handleJoinRoom");
            careStationTypeEmoted = null;
            var _local_2 = _shell.getMyPlayerObject();
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_3 = _shell.getRoomObject();
                _roomCareEffects = com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.getCareEffectsByRoomKey(_local_3.room_key);
                if (_roomCareEffects != null) {
                    trace("JC:PuffleCareEmoteManager there is room care effects for this room");
                    clearTimeout(_roomEmoteStartTimer);
                    var _local_4 = Math.floor(Math.random() * MAX_ROOM_EMOTE_START_WAIT_TIME);
                    _roomEmoteStartTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, onRoomEmoteStartTimerDone), _local_4);
                }
            }
        }
        function onRoomEmoteStartTimerDone() {
            trace("JC:PuffleCareEmoteManager onRoomEmoteStartTimerDone");
            clearTimeout(_roomEmoteStartTimer);
            var _local_3 = _shell.getMyPlayerObject();
            var _local_4 = _engine.puffleAvatarController.getPuffleAvatar(_local_3.attachedPuffle.id);
            var _local_2 = _local_4.getPuffleClip();
            trace("JC:PuffleCareEmoteManager puffleClip " + _local_2);
            if (_local_2) {
                trace("JC:show emote");
                showEmote(_local_3.attachedPuffle, _local_2, _roomCareEffects, ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
            } else {
                trace("JC:load avatar");
                _shell.addListener(_shell.PUFFLE_AVATAR_CLIP_LOADED, _delegateOnPuffleClipLoaded);
            }
        }
        function onPuffleClipLoaded(puffleID) {
            trace("JC:load onPuffleClipLoaded");
            _shell.removeListener(_shell.PUFFLE_AVATAR_CLIP_LOADED, _delegateOnPuffleClipLoaded);
            var _local_2 = _shell.getMyPlayerObject();
            var _local_3 = _engine.puffleAvatarController.getPuffleClip(_local_2.attachedPuffle.id);
            if (puffleID == _local_2.attachedPuffle.id) {
                showEmote(_local_2.attachedPuffle, _local_3, _roomCareEffects, ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
            }
        }
        static var ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD = 50;
        static var MAX_ROOM_EMOTE_START_WAIT_TIME = 10000;
    }
