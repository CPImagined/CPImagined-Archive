//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.manager.PuffleCareEmoteManager
    {
        var _shell, _engine, _puffleEmoteManager, _delegateOnPuffleClipLoaded, careStationTypeEmoted, _roomEmoteStartTimer, _roomCareEffects;
        function PuffleCareEmoteManager (_arg_3, _arg_4, _arg_2) {
            _shell = _arg_3;
            _engine = _arg_4;
            _puffleEmoteManager = _arg_2;
            _delegateOnPuffleClipLoaded = com.clubpenguin.util.Delegate.create(this, onPuffleClipLoaded);
            _shell.addListener(_shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, handleJoinRoom));
            _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed));
        }
        function showEmote(_arg_5, _arg_7, _arg_8, _arg_6) {
            var _local_3 = _arg_5.stats.getLowestStatType(_arg_8, _arg_6);
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
                _puffleEmoteManager.showEmote(_arg_5.id, _arg_7, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.CARE_EMOTE_STATE, _local_4);
            }
        }
        function handleRoomDestroyed() {
            clearTimeout(_roomEmoteStartTimer);
        }
        function handleJoinRoom() {
            careStationTypeEmoted = null;
            var _local_2 = _shell.getMyPlayerObject();
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_3 = _shell.getRoomObject();
                _roomCareEffects = com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.getCareEffectsByRoomKey(_local_3.room_key);
                if (_roomCareEffects != null) {
                    clearTimeout(_roomEmoteStartTimer);
                    var _local_4 = Math.floor(Math.random() * MAX_ROOM_EMOTE_START_WAIT_TIME);
                    _roomEmoteStartTimer = setTimeout(com.clubpenguin.util.Delegate.create(this, onRoomEmoteStartTimerDone), _local_4);
                }
            }
        }
        function onRoomEmoteStartTimerDone() {
            clearTimeout(_roomEmoteStartTimer);
            var _local_2 = _shell.getMyPlayerObject();
            var _local_4 = _engine.puffleAvatarController.getPuffleAvatar(_local_2.attachedPuffle.id);
            var _local_3 = _local_4.getPuffleClip();
            if (_local_3) {
                showEmote(_local_2.attachedPuffle, _local_3, _roomCareEffects, ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
            } else {
                _shell.addListener(_shell.PUFFLE_AVATAR_CLIP_LOADED, _delegateOnPuffleClipLoaded);
            }
        }
        function onPuffleClipLoaded(_arg_4) {
            _shell.removeListener(_shell.PUFFLE_AVATAR_CLIP_LOADED, _delegateOnPuffleClipLoaded);
            var _local_2 = _shell.getMyPlayerObject();
            var _local_3 = _engine.puffleAvatarController.getPuffleClip(_local_2.attachedPuffle.id);
            if (_arg_4 == _local_2.attachedPuffle.id) {
                showEmote(_local_2.attachedPuffle, _local_3, _roomCareEffects, ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD);
            }
        }
        static var ROOM_CARE_EFFECT_LOW_STAT_THRESHOLD = 50;
        static var MAX_ROOM_EMOTE_START_WAIT_TIME = 10000;
    }
