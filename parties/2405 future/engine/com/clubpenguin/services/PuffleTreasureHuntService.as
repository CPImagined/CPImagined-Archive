//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.PuffleTreasureHuntService extends com.clubpenguin.services.AbstractService
    {
        var _lastSuccessfulDig, _timeStoredBeforePause, _overlayCounterForPausing, treasureFound, _SHELL, _trackerAS2, _minTreasureHuntTime, _puffleTreasureHuntingEnabled, _autoReenable, connection, extension, messageFormat;
        function PuffleTreasureHuntService (connection, localPlayerID) {
            super(connection);
            _lastSuccessfulDig = new Date();
            _timeStoredBeforePause = new Date();
            _overlayCounterForPausing = 0;
            treasureFound = new org.osflash.signals.Signal(com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO);
            _SHELL = _global.getCurrentShell();
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            _minTreasureHuntTime = DEFAULT_TIME;
            _puffleTreasureHuntingEnabled = true;
            _autoReenable = true;
            _SHELL.addListener(_SHELL.ENABLE_PUFFLE_TREASURE_HUNTING, com.clubpenguin.util.Delegate.create(this, onEnablePuffleTreasureHunting));
            _SHELL.addListener(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, com.clubpenguin.util.Delegate.create(this, onDisablePuffleTreasureHunting));
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, com.clubpenguin.util.Delegate.create(this, onPenguinStopsMoving));
            connection.getResponded().add(onResponded, this);
        }
        function startTreasureHunting() {
            if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                return(undefined);
            }
            _overlayCounterForPausing--;
            if (_overlayCounterForPausing < 0) {
                _overlayCounterForPausing = 0;
            }
            if ((_overlayCounterForPausing == 0) && (_timeStoredBeforePause != null)) {
                var _local_2 = new Date().getTime() - _timeStoredBeforePause.getTime();
                _lastSuccessfulDig.setTime(_lastSuccessfulDig.getTime() + _local_2);
                _timeStoredBeforePause = null;
            }
        }
        function stopTreasureHunting() {
            if (_overlayCounterForPausing == 0) {
                _timeStoredBeforePause = new Date();
            }
            _overlayCounterForPausing++;
        }
        function onPenguinStopsMoving(playerObject) {
            if (!_SHELL.isMyPlayer(playerObject.player_id)) {
                return(undefined);
            }
            if (playerObject.isUsingSlide) {
                return(undefined);
            }
            if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(playerObject, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                return(undefined);
            }
            if (!_global.getCurrentInterface().is_quick_keys_active) {
                return(undefined);
            }
            if (_SHELL.getIsRoomIgloo()) {
                return(undefined);
            }
            if (_global.getCurrentEngine().isRoomMyBackyard()) {
                return(undefined);
            }
            if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                return(undefined);
            }
            if (!_global.getCurrentEngine().puffleAvatarController.isPuffleVisible(playerObject.attachedPuffle.id)) {
                return(undefined);
            }
            if (environmentBehaviorHitTest(_global.getCurrentEngine().puffleAvatarController.getPuffleClip(playerObject.attachedPuffle.id))) {
                return(undefined);
            }
            if (readyToDig()) {
                if (_puffleTreasureHuntingEnabled) {
                    huntForTreasure();
                    _lastSuccessfulDig = new Date();
                }
            } else {
                _global.getCurrentEngine().puffleTreasureContext.getDigSearchEmoteManager().displayPuffleEmote(playerObject);
            }
            if (_autoReenable && (!_puffleTreasureHuntingEnabled)) {
                onEnablePuffleTreasureHunting(playerObject.player_id);
            }
        }
        function readyToDig() {
            var _local_2 = new Date();
            if (_local_2.getTime() >= (_lastSuccessfulDig.getTime() + _minTreasureHuntTime)) {
                return(true);
            }
            return(false);
        }
        function environmentBehaviorHitTest(playerMC) {
            return(_global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(playerMC));
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case PUFFLE_TREASURE : 
                    var _local_4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                    var _local_2 = new com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO("treasureFound");
                    _local_2.puffleId = Number(responseData[2]);
                    _local_2.treasureType = Number(responseData[3]);
                    _local_2.treasureId = Number(responseData[4]);
                    _local_2.quantity = Number(responseData[5]);
                    _local_2.isFirstSuccessfulDig = ((Number(responseData[6]) == 1) ? true : false);
                    _local_2.playerVO = _local_4;
                    treasureFound.dispatch(_local_2);
                    if (_local_4.player_id == _SHELL.getMyPlayerId()) {
                        var _local_5 = ((Number(responseData[7]) == 1) ? true : false);
                        sendPuffleDigSuccessBI(_local_2, _local_5);
                    }
                    break;
                case NO_TREASURE_FOUND : 
                    _local_4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                    if (_local_4.player_id == _SHELL.getMyPlayerId()) {
                        var _local_7 = String(_local_4.attachedPuffle["color"]);
                        var _local_8 = _local_4.attachedPuffle.subTypeID;
                        var _local_6 = String(_local_4.attachedPuffle.ageInDays);
                    }
                    break;
                case PUFFLE_GOLD_BERRY : 
                    _local_4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                    if (_local_4.player_id == _SHELL.getMyPlayerId()) {
                        _minTreasureHuntTime = GOLD_STATE_TIME;
                        _local_4.goldPuffleQuestStart = new Date();
                    }
                    break;
                case WALK_PUFFLE : 
                    _local_4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                    if (_local_4.player_id == _SHELL.getMyPlayerId()) {
                        _minTreasureHuntTime = DEFAULT_TIME;
                    }
                    break;
                default : 
                    return(undefined);
            }
        }
        function sendPuffleDigSuccessBI(puffleTreasureVO, failSafe) {
            var _local_2 = _SHELL.getMyPlayerObject();
            var _local_4 = String(_local_2.attachedPuffle["color"]);
            var _local_5 = _local_2.attachedPuffle.subTypeID;
            var _local_3 = String(_local_2.attachedPuffle.ageInDays);
        }
        function huntForTreasure() {
            connection.sendXtMessage(extension, PUFFLE_TREASURE_HANDLER + PUFFLE_TREASURE, [_SHELL.getMyPlayerId()], messageFormat, -1);
            return(treasureFound);
        }
        function onEnablePuffleTreasureHunting(playerID) {
            com.clubpenguin.util.Log.debug("onEnablePuffleTreasureHunting()");
            if (_SHELL.isMyPlayer(playerID)) {
                _puffleTreasureHuntingEnabled = true;
            }
        }
        function onDisablePuffleTreasureHunting(playerID) {
            com.clubpenguin.util.Log.debug("onDisablePuffleTreasureHunting()");
            if (_SHELL.isMyPlayer(playerID)) {
                _puffleTreasureHuntingEnabled = false;
            }
        }
        static var PUFFLE_TREASURE_HANDLER = "p#";
        static var PUFFLE_TREASURE = "puffledig";
        static var NO_TREASURE_FOUND = "nodig";
        static var PUFFLE_GOLD_BERRY = "oberry";
        static var WALK_PUFFLE = "pw";
        static var DEFAULT_TIME = 60000;
        static var GOLD_STATE_TIME = 50000;
    }
