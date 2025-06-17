class com.clubpenguin.services.PuffleTreasureHuntService extends com.clubpenguin.services.AbstractService
{
    var _lastSuccessfulDig, _timeStoredBeforePause, _overlayCounterForPausing, treasureFound, _SHELL, _trackerAS2, _minTreasureHuntTime, _puffleTreasureHuntingEnabled, _autoReenable, messageFormat, extension, connection;
    function PuffleTreasureHuntService(connection, localPlayerID)
    {
        super(connection);
        _lastSuccessfulDig = new Date();
        _timeStoredBeforePause = new Date();
        _overlayCounterForPausing = 0;
        treasureFound = new org.osflash.signals.Signal(com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO);
        _SHELL = _global.getCurrentShell();
        _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
        _minTreasureHuntTime = com.clubpenguin.services.PuffleTreasureHuntService.DEFAULT_TIME;
        _puffleTreasureHuntingEnabled = true;
        _autoReenable = true;
        _SHELL.addListener(_SHELL.ENABLE_PUFFLE_TREASURE_HUNTING, com.clubpenguin.util.Delegate.create(this, onEnablePuffleTreasureHunting));
        _SHELL.addListener(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, com.clubpenguin.util.Delegate.create(this, onDisablePuffleTreasureHunting));
        _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, com.clubpenguin.util.Delegate.create(this, onPenguinStopsMoving));
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function startTreasureHunting()
    {
        if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))
        {
            return;
        } // end if
        --_overlayCounterForPausing;
        if (_overlayCounterForPausing < 0)
        {
            _overlayCounterForPausing = 0;
        } // end if
        if (_overlayCounterForPausing == 0 && _timeStoredBeforePause != null)
        {
            var _loc2 = new Date().getTime() - _timeStoredBeforePause.getTime();
            _lastSuccessfulDig.setTime(_lastSuccessfulDig.getTime() + _loc2);
            _timeStoredBeforePause = null;
        } // end if
    } // End of the function
    function stopTreasureHunting()
    {
        if (_overlayCounterForPausing == 0)
        {
            _timeStoredBeforePause = new Date();
        } // end if
        ++_overlayCounterForPausing;
    } // End of the function
    function onPenguinStopsMoving(playerObject)
    {
        if (!_SHELL.isMyPlayer(playerObject.player_id))
        {
            return;
        } // end if
        if (playerObject.isUsingSlide)
        {
            return;
        } // end if
        if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(playerObject, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))
        {
            return;
        } // end if
        if (!_global.getCurrentInterface().is_quick_keys_active)
        {
            return;
        } // end if
        if (_SHELL.getIsRoomIgloo())
        {
            return;
        } // end if
        if (_global.getCurrentEngine().isRoomMyBackyard())
        {
            return;
        } // end if
        if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))
        {
            return;
        } // end if
        if (!_global.getCurrentEngine().puffleAvatarController.isPuffleVisible(playerObject.attachedPuffle.id))
        {
            return;
        } // end if
        if (this.environmentBehaviorHitTest(_global.getCurrentEngine().puffleAvatarController.getPuffleClip(playerObject.attachedPuffle.id)))
        {
            return;
        } // end if
        if (this.readyToDig())
        {
            if (_puffleTreasureHuntingEnabled)
            {
                this.huntForTreasure();
                _lastSuccessfulDig = new Date();
            } // end if
        }
        else
        {
            _global.getCurrentEngine().puffleTreasureContext.getDigSearchEmoteManager().displayPuffleEmote(playerObject);
        } // end else if
        if (_autoReenable && !_puffleTreasureHuntingEnabled)
        {
            this.onEnablePuffleTreasureHunting(playerObject.player_id);
        } // end if
    } // End of the function
    function readyToDig()
    {
        var _loc2 = new Date();
        if (_loc2.getTime() >= _lastSuccessfulDig.getTime() + _minTreasureHuntTime)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function environmentBehaviorHitTest(playerMC)
    {
        return (_global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(playerMC));
    } // End of the function
    function onResponded(responseType, responseData)
    {
        switch (responseType)
        {
            case com.clubpenguin.services.PuffleTreasureHuntService.PUFFLE_TREASURE:
            {
                var _loc4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                var _loc2 = new com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO("treasureFound");
                _loc2.puffleId = Number(responseData[2]);
                _loc2.treasureType = Number(responseData[3]);
                _loc2.treasureId = Number(responseData[4]);
                _loc2.quantity = Number(responseData[5]);
                _loc2.isFirstSuccessfulDig = Number(responseData[6]) == 1 ? (true) : (false);
                _loc2.playerVO = _loc4;
                treasureFound.dispatch(_loc2);
                if (_loc4.player_id == _SHELL.getMyPlayerId())
                {
                    var _loc5 = Number(responseData[7]) == 1 ? (true) : (false);
                    this.sendPuffleDigSuccessBI(_loc2, _loc5);
                } // end if
                break;
            } 
            case com.clubpenguin.services.PuffleTreasureHuntService.NO_TREASURE_FOUND:
            {
                _loc4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                if (_loc4.player_id == _SHELL.getMyPlayerId())
                {
                    var _loc7 = String(_loc4.attachedPuffle.color);
                    var _loc8 = _loc4.attachedPuffle.subTypeID;
                    var _loc6 = String(_loc4.attachedPuffle.ageInDays);
                } // end if
                break;
            } 
            case com.clubpenguin.services.PuffleTreasureHuntService.PUFFLE_GOLD_BERRY:
            {
                _loc4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                if (_loc4.player_id == _SHELL.getMyPlayerId())
                {
                    _minTreasureHuntTime = com.clubpenguin.services.PuffleTreasureHuntService.GOLD_STATE_TIME;
                    _loc4.goldPuffleQuestStart = new Date();
                } // end if
                break;
            } 
            case com.clubpenguin.services.PuffleTreasureHuntService.WALK_PUFFLE:
            {
                _loc4 = _SHELL.getPlayerObjectById(Number(responseData[1]));
                if (_loc4.player_id == _SHELL.getMyPlayerId())
                {
                    _minTreasureHuntTime = com.clubpenguin.services.PuffleTreasureHuntService.DEFAULT_TIME;
                } // end if
                break;
            } 
            default:
            {
                return;
            } 
        } // End of switch
    } // End of the function
    function sendPuffleDigSuccessBI(puffleTreasureVO, failSafe)
    {
        var _loc2 = _SHELL.getMyPlayerObject();
        var _loc4 = String(_loc2.attachedPuffle.color);
        var _loc5 = _loc2.attachedPuffle.subTypeID;
        var _loc3 = String(_loc2.attachedPuffle.ageInDays);
    } // End of the function
    function huntForTreasure()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.PuffleTreasureHuntService.PUFFLE_TREASURE_HANDLER + com.clubpenguin.services.PuffleTreasureHuntService.PUFFLE_TREASURE, [_SHELL.getMyPlayerId()], messageFormat, -1);
        return (treasureFound);
    } // End of the function
    function onEnablePuffleTreasureHunting(playerID)
    {
        com.clubpenguin.util.Log.debug("onEnablePuffleTreasureHunting()");
        if (_SHELL.isMyPlayer(playerID))
        {
            _puffleTreasureHuntingEnabled = true;
        } // end if
    } // End of the function
    function onDisablePuffleTreasureHunting(playerID)
    {
        com.clubpenguin.util.Log.debug("onDisablePuffleTreasureHunting()");
        if (_SHELL.isMyPlayer(playerID))
        {
            _puffleTreasureHuntingEnabled = false;
        } // end if
    } // End of the function
    static var PUFFLE_TREASURE_HANDLER = "p#";
    static var PUFFLE_TREASURE = "puffledig";
    static var NO_TREASURE_FOUND = "nodig";
    static var PUFFLE_GOLD_BERRY = "oberry";
    static var WALK_PUFFLE = "pw";
    static var DEFAULT_TIME = 60000;
    static var GOLD_STATE_TIME = 50000;
} // End of Class
